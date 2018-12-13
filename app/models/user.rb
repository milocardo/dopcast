class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :playlists
  has_many :subscriptions
  has_many :episodes, through: :playlists
  has_many :podcasts, through: :subscriptions
  has_many :reviews

  include PublicActivity::Model
  include PublicActivity::Activist
  tracked #owner: proc { |controller, model| controller.current_user ? controller.current_user : nil }

  mount_uploader :photo, PhotoUploader

  acts_as_voter
  acts_as_followable
  acts_as_follower
end
