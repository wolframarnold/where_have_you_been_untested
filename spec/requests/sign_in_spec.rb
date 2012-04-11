require 'spec_helper'

describe "User Sign In" do

  before do
    @joe = FactoryGirl.create(:user)
  end

  it 'can sign in and is redirected to home page' do
    # request home page
    visit('/')
    # click sign in
    click_link 'Sign In'

    current_path.should == '/users/sign_in'

    fill_in("Email", :with => @joe.email)
    fill_in("Password", :with => @joe.password)

    click_button "Sign in"

    current_path.should == '/trips'

    # check I'm on the sign-in page
    # fill in email, password
    # click sign in button
    # check redirect to trips page

  end

end