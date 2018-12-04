class Playlist < ApplicationRecord
  has_many :episodes
  belongs_to :user
end
