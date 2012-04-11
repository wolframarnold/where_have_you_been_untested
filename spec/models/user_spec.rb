require 'spec_helper'

describe User do

  describe "Associations" do

    it '.trips should exist' do
      u = User.new

      u.should respond_to(:trips)
    end

    it 'can create a trip from the user' do
      u = FactoryGirl.create(:user)
      expect {
        u.trips.create(name: "Test trip")
      }.to change{u.trips.count}.by(1)
    end

  end

end