class Podcast < ApplicationRecord
  # has_many :episodes

  include PgSearch
  multisearchable against: [ :total_episodes,
                             :itunes_id,
                             :image,
                             :title,
                             :episodes,
                             :country,
                             :description,
                             :language,
                             :korean_id,
                             :lastest_pub_date_ms,
                             :earliest_pub_date_ms,
                             :publisher,
                             :genres,
                             :extra
                           ]
  validates :korean_id, uniqueness: true

  acts_as_votable
  acts_as_commentable
  acts_as_followable
end
