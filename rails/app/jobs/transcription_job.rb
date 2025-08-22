# app/jobs/transcription_job.rb
class TranscriptionJob < ApplicationJob
  def perform(post_id)
    post = Post.find(post_id)
    return unless post
    return unless post.processing?

    begin # Add a begin..rescue block to catch errors
      sleep 5 # Simulate network latency and processing time

      simulated_transcript = "This is a simulated transcription. The recording was successfully received and processed by the background job. In a real application, this text would come from an AI transcription service."

      # Update the post and broadcast completion
      post.update!(raw_transcript: simulated_transcript, status: :completed)

    rescue StandardError => e # Catch any errors during the processing
      Rails.logger.error "TranscriptionJob failed for Post ID #{post_id}: #{e.message}"
      post.update!(status: :failed) # Mark post as failed
    end
  end
end