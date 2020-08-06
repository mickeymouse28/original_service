class Log < ApplicationRecord
  belongs_to :user
  
  validates :placename, presence: true, length: { maximum: 100 }
  validates :date, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites
  has_many :likes, through: :favorites, source: :user, dependent: :destroy
end
