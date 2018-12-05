class Podcast < ApplicationRecord
  has_many :episodes
  acts_as_votable
  acts_as_commentable
end
