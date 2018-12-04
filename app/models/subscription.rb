class Subscription < ApplicationRecord
  has_many :podcasts
  belongs_to :user
end
