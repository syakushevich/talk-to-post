// app/javascript/controllers/recording_controller.js
import { Controller } from "@hotwired/stimulus";

// Helper to get the Rails CSRF token
function getMetaValue(name) {
  const element = document.head.querySelector(`meta[name="${name}"]`);
  return element.getAttribute("content");
}

export default class extends Controller {
  // Update targets to reflect the new span elements
  static targets = ["button", "iconMic", "iconRecording"];

  connect() {
    this.recorder = null;
    this.audioChunks = [];
    this.isRecording = false;
  }

  // Triggered on "mousedown"
  async start(event) {
    event.preventDefault();
    if (this.isRecording) return;

    // Request microphone access
    try {
      const stream = await navigator.mediaDevices.getUserMedia({
        audio: true,
      });
      this.isRecording = true;
      this.startRecording(stream);
    } catch (err) {
      console.error("Error accessing microphone:", err); // Keep this for debugging the *real* mic error
      alert(
        "Microphone access was denied. Please allow access to continue."
      );
      // Reset button state if mic access fails after all
      this.resetButton();
    }
  }

  // Triggered on "mouseup" or "mouseleave"
  stop(event) {
    event.preventDefault();
    if (!this.isRecording) return;

    this.recorder.stop();
    this.isRecording = false;
    // The 'stop' event on the recorder will trigger the upload
  }

  startRecording(stream) {
    this.recorder = new MediaRecorder(stream);

    // Clear out any previous chunks
    this.audioChunks = [];

    // Push audio data to our array when it's available
    this.recorder.addEventListener("dataavailable", (event) => {
      this.audioChunks.push(event.data);
    });

    // When recording stops, create a blob and upload it
    this.recorder.addEventListener("stop", () => {
      const audioBlob = new Blob(this.audioChunks, {
        type: "audio/webm",
      });
      this.upload(audioBlob);
      // Stop all tracks on the stream to turn off the mic indicator
      stream.getTracks().forEach((track) => track.stop());
    });

    // Change button style to indicate recording
    this.buttonTarget.classList.replace("btn-primary", "btn-danger");
    // Hide mic icon, show recording icon
    this.iconMicTarget.classList.add("d-none");
    this.iconRecordingTarget.classList.remove("d-none");

    // Start recording
    this.recorder.start();
  }

  upload(blob) {
    const formData = new FormData();
    // The key 'post[audio]' is crucial to match Rails' strong params
    formData.append("post[audio]", blob, "recording.webm");

    fetch("/posts", {
      method: "POST",
      headers: {
        "X-CSRF-Token": getMetaValue("csrf-token"),
      },
      body: formData,
    }).then((response) => {
      if (response.ok) {
        // If successful, Turbo will handle the redirect
        window.Turbo.visit(response.url);
      } else {
        console.error("Upload failed.");
        this.resetButton();
      }
    });
  }

  resetButton() {
    this.buttonTarget.classList.replace("btn-danger", "btn-primary");
    // Show mic icon, hide recording icon
    this.iconRecordingTarget.classList.add("d-none");
    this.iconMicTarget.classList.remove("d-none");
  }
}