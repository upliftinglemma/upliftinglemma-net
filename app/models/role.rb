##
# This class represents a user's role in an app.
#
# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  app_id     :integer          not null
#  user_id    :integer          not null
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ActiveRecord::Base
  has_paper_trail

  belongs_to :app
  belongs_to :user
end
