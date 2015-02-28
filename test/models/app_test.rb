# == Schema Information
#
# Table name: apps
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  engine     :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  license    :string
#

require 'test_helper'

class AppTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
