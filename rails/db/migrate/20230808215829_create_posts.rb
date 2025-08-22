class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.text :name
      t.text :raw_transcript
      t.text :generated_post
      t.string :status

      t.timestamps
    end
  end
end
