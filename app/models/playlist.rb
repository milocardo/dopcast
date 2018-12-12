class Playlist < ApplicationRecord
  has_many :episodes
  belongs_to :user

  include PublicActivity::Model
  tracked

  acts_as_votable
  acts_as_commentable
  acts_as_followable
end
