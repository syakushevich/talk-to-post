class Post < ApplicationRecord
  has_one_attached :audio

  enum :status, { processing: "processing", completed: "completed", failed: "failed" }

  private

  def self.dom_id(record, prefix = nil)
    ActionView::RecordIdentifier.dom_id(record, prefix)
  end
end
