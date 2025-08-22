# app/jobs/transcription_job.rb
class TranscriptionJob < ApplicationJob
  def perform(post_id)
    post = Post.find(post_id)
    return unless post&.processing?

    begin
      sleep 5 # Simulate processing
      simulated_transcript = "This is the final, correct transcription from the background job!"
      post.update!(raw_transcript: simulated_transcript, status: :completed)

      # Manually broadcast the update to the correct stream and target
      post.broadcast_replace_to(
        [post, :transcription],
        target: ActionView::RecordIdentifier.dom_id(post, :transcription_result),
        partial: "posts/transcription",
        locals: { post: post }
      )

    rescue StandardError => e
      Rails.logger.error "TranscriptionJob failed for Post ID #{post_id}: #{e.message}"
      post.update!(status: :failed)
    end
  end
end