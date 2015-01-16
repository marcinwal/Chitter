require 'spec_helper'

feature "User signs in" do
  scenario "with nothing he should see chitter" do 
    visit '/'
    expect(page).to have_content("Hello Chitter!")
  end 

end