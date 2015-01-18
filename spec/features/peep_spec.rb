require 'spec_helper'
require_relative 'helpers/session_helpers'

feature 'user can add pips once he is logged in' do
  include SessionHelpers

  scenario "user can add a peep when he is logged in" do 
    user = user_create
    visit '/'

  end

end