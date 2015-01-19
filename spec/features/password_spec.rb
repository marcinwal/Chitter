require 'spec_helper'
require_relative 'helpers/session_helpers'

feature 'password' do 
  include SessionHelpers

  scenario "should have the option to recover" do 
    visit '/'
    click_link("Pass")
    expect(page).to have_content("Password recovery! Please provide your email")
  end


  scenario "email should be sent" do 
    user = user_create
    visit '/'
    click_link("Pass")
    fill_in :email, :with => "test@test.com"
    click_button("request")
    # save_and_open_page
    expect(page).to have_content("Token has been sent to you!")
  end
end