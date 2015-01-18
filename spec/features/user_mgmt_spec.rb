require 'spec_helper'
require 'byebug'
require_relative 'helpers/session_helpers'

feature "User signs in" do

  include SessionHelpers



   before(:each) do 
     User.create(:email => "test@test.com",
                 :name => "Testname",
                 :username => "Testusername",
                 :password => 'test',
                 :password_confirmation => 'test')
   end

  scenario "with nothing he should see chitter" do 
    visit '/'
    expect(page).to have_content("Hello Chitter!")
  end 

  scenario "user can sign up" do 
    visit '/'
    click_link("sign-up")   #click link with id 'sign-up'
    expect(page).to have_content("Please sign up")
  end

  scenario "user can sign up with correct data" do
    visit '/'
    click_link("sign-up") #going to usernew.erb page with the form to fill in
    expect{ sign_up }.to change(User, :count).by(1)
  end

  scenario ""

  scenario "user can sign out" do 
    user = user_create
    visit '/'
    save_and_open_page
    click_button("Sign out")
    expect(page).to have_content("Good bye!")
  end

end