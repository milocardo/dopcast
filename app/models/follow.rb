class Follow < ActiveRecord::Base

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" and "follower" interface
  belongs_to :followable, polymorphic: true
  belongs_to :follower,   polymorphic: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def block!
    self.update_attribute(:blocked, true)
  end

end
