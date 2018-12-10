class Episode < ApplicationRecord
  belongs_to :podcast
  has_many :reviews

  include PgSearch
  multisearchable against: [ :audio,
                             :korean_podcast_id,
                             :itunes_id,
                             :audio_length,
                             :description_original,
                             :genres,
                             :image,
                             :publisher_original,
                             :title_original,
                             :pub_date_ms,
                             :podcast_title_original
                           ]
  validates :korean_podcast_id, uniqueness: true
  multisearchable against: [ :title, :description, :guest ]

  include PublicActivity::Model
  tracked

  acts_as_votable
  acts_as_commentable
end
