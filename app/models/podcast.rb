class Podcast < ApplicationRecord
  has_many :episodes
  include PgSearch
  multisearchable against: [ :image, :title, :category, :language, :description ]
end
