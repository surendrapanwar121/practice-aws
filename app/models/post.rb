class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  enum status: [:draft, :published, :archived, :trashed]

  validates :title, presence: true, length: { minimum: 10 }
  validate :image_presence

  private

  def image_presence
    if image.attached?
      if !image.content_type.in?(%w[image/png image/jpg image/jpeg])
        errors.add(:image, "must be a PNG, JPG, or JPEG file")
      elsif image.blob.byte_size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    else
      errors.add(:image, "must be attached")
    end
  end
end
