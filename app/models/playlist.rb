class Playlist < ApplicationRecord
  has_many :playlist_episodes
  has_many :episodes, through: :playlist_episodes
  belongs_to :user

  include PgSearch
  multisearchable against: %i[name user_id]
  include PublicActivity::Model
  tracked

  acts_as_votable
  acts_as_commentable
  acts_as_followable
end
