class Homework < ApplicationRecord
  belongs_to :user

  validates :work_on, presence: true
  validates :note, length: { maximum: 50 }
end
