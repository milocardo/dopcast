class Episode < ApplicationRecord
  belongs_to :podcast
  has_many :reviews
end
