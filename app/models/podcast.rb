class Podcast < ApplicationRecord
  has_many :episodes

  # include PgSearch
  # multisearchable against: [ :image, :title, :category, :language, :description ]

  acts_as_votable
  acts_as_commentable
  acts_as_followable
end
