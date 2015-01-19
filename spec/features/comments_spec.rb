require 'spec_helper'
require_relative 'helpers/session_helpers'

feature 'user ' do
  include SessionHelpers

  scenario "can add comments when he is logged in" do 
    user = user_create
    visit '/'
    click_link("Sign in")
    sign_in
    click_link("newpeep")
    fill_in :newpeep, :with => "Test text"
    click_button("Add peep")
    expect(page).to have_content("Test text")
    click_button("Comment")
    expect(page).to have_content("Your comment:")
  end

  scenario "can add and  see comments when he is logged in" do 
    user = user_create
    visit '/'
    click_link("Sign in")
    sign_in
    click_link("newpeep")
    fill_in :newpeep, :with => "Test text"
    click_button("Add peep")
    expect(page).to have_content("Test text")
    click_button("Comment")
    fill_in :newcomment, :with => "Test comment"
    click_button("Comment now")
    expect(Comment.count).to eq(1)
  end

end