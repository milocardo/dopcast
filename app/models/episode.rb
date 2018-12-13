class Episode < ApplicationRecord
  belongs_to :podcast, optional: true
  has_many :playlist_episodes
  has_many :playlists, through: :playlist_episodes
  has_many :reviews


  include PgSearch
  multisearchable against: [ :audio_length,
                             :title,
                             :audio,
                             :description,
                             :pub_date_ms,
                             :image,
                             :korean_episode_id,
                             :podcast,
                           ]
  validates :korean_episode_id, uniqueness: true

  include PublicActivity::Model
  tracked

  acts_as_votable
  acts_as_commentable

  def searchable
    self
  end
end
