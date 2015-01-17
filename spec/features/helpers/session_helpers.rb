module SessionHelpers 
  def sign_in(email, password)
    visit '/sessions/new'
    #save_and_open_page      SAVE IN M
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button 'Sign in'
  end

  def sign_up(email = "alice@example.com",
              name = "alice name",
              username = "alice",
              password = "oranges!",
              password_confirmation = "oranges!")


      visit '/user/new'
      expect(page.status_code).to eq(200)
      fill_in :name, :with => name
      fill_in :usera_name, :with => name
      fill_in :email, :with => email
      fill_in :password, :with => password
      fill_in :password_confirmation, :with => password_confirmation
      click_button "Sign up"
  end 
end