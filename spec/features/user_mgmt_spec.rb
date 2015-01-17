require 'spec_helper'
require_relative 'helpers/session_helpers'

feature "User signs in" do



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

end