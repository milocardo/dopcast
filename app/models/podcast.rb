class Podcast < ApplicationRecord
  has_many :episodes

  include PgSearch
  multisearchable against: [ #:total_episodes,
                             #:itunes_id,
                             #:image,
                             :title,
                             # :episodes_list,
                             :country,
                             :description,
                             :language,
                             #:korean_id,
                             #:lastest_pub_date_ms,
                             #:earliest_pub_date_ms,
                             :publisher,
                             :genres,
                             #:extra
                           ]
  validates :itunes_id, uniqueness: true, presence: true

  include PublicActivity::Model
  tracked

  def searchable
    self
  end

  acts_as_votable
  acts_as_commentable
  acts_as_followable
end
