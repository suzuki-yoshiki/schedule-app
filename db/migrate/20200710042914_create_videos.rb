class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.text :body
      t.string :youtube_url

      t.timestamps
    end
  end
end
