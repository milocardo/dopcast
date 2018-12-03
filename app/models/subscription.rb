class Subscription < ApplicationRecord
  belongs_to :podcast
  belongs_to :user
end
