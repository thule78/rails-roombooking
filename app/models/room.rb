class Room < ApplicationRecord
  enum instant: {Request: 0, Instant: 1}


  belongs_to :user
  has_many :photos
  has_many :reservations

  has_many :guest_reviews


  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true, length: { maximum: 200 }
  validates :room_type, presence: true, length: { maximum: 100 }
  validates :accommodate, presence: true
  validates :bed_room, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
  validates :bath_room, presence: true, numericality: { only_integer: true, greater_than: 0}

  def cover_photo(size)
    if self.photos.length > 0
      self.photos[0].image.url(size)
    else
      "room_cover.jpg"
    end

  end

  def average_rating
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end

end
