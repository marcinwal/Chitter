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

  scenario "user can sign in" do
    user = user_create
    visit '/'
    click_link("Sign in")
    fill_in :email_or_username , :with => "test@test.com"
    fill_in :password, :with => "test"
    click_button("Sign in")
    expect(page).to have_content("Welcome back Testusername")
  end 

  scenario "user cannot sign in with wrong username" do 
    user = user_create
    visit '/'
    click_link("Sign in")
    fill_in :email_or_username , :with => "1test@test.com"
    fill_in :password, :with => "test"
    click_button("Sign in")
    expect(page).to have_content("Wrong email, username or password")
  end

  scenario "user cannot sign in with wrong password" do 
    user = user_create
    visit '/'
    click_link("Sign in")
    fill_in :email_or_username , :with => "test@test.com"
    fill_in :password, :with => "test1"
    click_button("Sign in")
    expect(page).to have_content("Wrong email, username or password")
  end

  scenario "user can sign out" do 
    u = user_create
    visit '/'
    click_link("Sign in")
    sign_in("test@test.com","test")
    save_and_open_page

    click_button("Sign out")
    expect(page).to have_content("Good bye!")
  end

end