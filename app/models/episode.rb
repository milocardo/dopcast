class Episode < ApplicationRecord
  belongs_to :podcast
  has_many :reviews
  acts_as_votable
  acts_as_commentable
end
