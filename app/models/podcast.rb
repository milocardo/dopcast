class Podcast < ApplicationRecord
  has_many :episodes

  include PgSearch
  multisearchable against: [ :image, :collection_id, :collection_name, :artist_name, :genre, :country ]
  validates :collection_id, uniqueness: true

  acts_as_votable
  acts_as_commentable
end
