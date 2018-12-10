class Episode < ApplicationRecord
  belongs_to :podcast
  has_many :reviews

  # include PgSearch
  # multisearchable against: [ :title, :description, :guest ]

  acts_as_votable
  acts_as_commentable
end
