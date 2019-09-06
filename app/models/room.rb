class Room < ApplicationRecord
  belongs_to :user
  has_many :photos

  validates :home_type, presence: true, length: { maximum: 200 }
  validates :room_type, presence: true, length: { maximum: 100 }
  validates :accommodate, presence: true
  validates :bed_room, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
  validates :bath_room, presence: true, numericality: { only_integer: true, greater_than: 0}
end
