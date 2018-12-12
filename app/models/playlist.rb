class Playlist < ApplicationRecord
  has_many :episodes
  belongs_to :user
<<<<<<< HEAD
  include PgSearch
  multisearchable against: [ :name,
                             :episode_id,
                             :user_id
                            ]
=======

  include PublicActivity::Model
  tracked

  acts_as_votable
  acts_as_commentable
  acts_as_followable
>>>>>>> dd80a41f75650c07ef00d03a9e8e9336f722a418
end
