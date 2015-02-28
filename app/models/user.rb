##
# This class represents a user that can log in to the website.
#
# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
    has_paper_trail

    has_many :roles

    has_many :apps
end
