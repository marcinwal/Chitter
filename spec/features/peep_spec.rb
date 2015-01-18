require 'spec_helper'
require_relative 'helpers/session_helpers'

feature 'user ' do
  include SessionHelpers

  scenario "can add a peep when he is logged in" do 
    user = user_create
    visit '/'
    click_link("Sign in")
    sign_in
    click_link("newpeep")
  end

end