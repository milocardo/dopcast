class PlaylistEpisode < ApplicationRecord
  belongs_to :episode
  belongs_to :playlist

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
end
