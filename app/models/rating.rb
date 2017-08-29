class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :bathroom

  validates :user_id, :bathroom_id, presence: true
end

