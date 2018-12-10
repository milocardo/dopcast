class Podcast < ApplicationRecord
  has_many :episodes

  include PgSearch
  multisearchable against: [ :title, :itunes_id, :total_episodes, :image, :publisher_original, :korean_id ]
  validates :korean_id, uniqueness: true

  acts_as_votable
  acts_as_commentable
  acts_as_followable
end
