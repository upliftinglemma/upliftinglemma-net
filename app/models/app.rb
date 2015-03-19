##
# This class represents an app on the website.
#
# == Schema Information
#
# Table name: apps
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  engine_name :string           not null
#  slug        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#  license     :string
#

class App < ActiveRecord::Base
  include FriendlyId

  has_paper_trail

  has_many :roles
  has_many :users, through: :roles

  friendly_id :name, use: :slugged

  validates_presence_of :name, :type, :slug


  def route_name
    "#{slug.underscore}_app"
  end


  ##
  # Look up the app's engine by the type (i.e., the namespace).
  #
  def engine
    type.deconstantize.constantize::Engine
  end


  ##
  # Look up the app's owner by role.
  #
  def owner
    User.joins(:roles).where(
      'roles.role' => 'owner',
      'roles.app_id' => id
    ).first
  end


  ##
  # Decide if this app is the default app.
  #
  def default?
    self == self.class.default
  end


  ##
  # Get the roles for the given user in this app.
  def roles_for user
    roles.where(user: user)
  end


  ##
  # The slug of the default app.
  #
  def self.default_slug
    'uplifting-lemma'
  end


  ##
  # Get the default app.
  #
  def self.default
    App.friendly.find(default_slug)
  end
end

