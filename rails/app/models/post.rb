class Post < ApplicationRecord
  has_one_attached :audio

  enum :status, { processing: "processing", completed: "completed", failed: "failed" }

  broadcasts_to ->(post) { [post, :transcription] }, target: ->(post) { dom_id(post, :transcription_result) }

  private

  def self.dom_id(record, prefix = nil)
    ActionView::RecordIdentifier.dom_id(record, prefix)
  end
end
