class Bathroom < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings

  validates :name, :description, :lat, :long, :address, :wheelchair, :childfriendly

  def ratings_total
    ratings.average(:ratings)
  end
end
