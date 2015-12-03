require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @user = User.new(name: "Test", email: "test@test.com", password: "testtest", password_confirmation: "testtest", fname: "baiming", lname: "zhang")
  end

end
