class PlaylistEpisode < ApplicationRecord
  belongs_to :episode
  belongs_to :playlist

  include PublicActivity::Model
  tracked
end
