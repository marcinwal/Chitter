require 'spec_helper'
require_relative 'helpers/session_helpers'

feature 'password' do 
  include SessionHelpers

  scenario "should have the option to recover" do 
    visit '/'
    click_link("Pass")
    expect(page).to have_content("Password recovery! Please provide your email")
  end
end