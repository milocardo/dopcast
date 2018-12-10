class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :episodes, through: :playlists
  has_many :podcasts, through: :subscriptions
  has_many :reviews

  include PublicActivity::Model
  tracked

  acts_as_voter
  acts_as_followable
  acts_as_follower
end
