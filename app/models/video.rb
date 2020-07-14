class Video < ApplicationRecord

  validates :body,  presence: true
  validates :youtube_url, presence: true
end
