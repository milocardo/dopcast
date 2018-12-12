class Playlist < ApplicationRecord
  has_many :episodes
  belongs_to :user
  include PgSearch
  multisearchable against: [ :name,
                             :episode_id,
                             :user_id
                            ]
end
