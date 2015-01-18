module SessionHelpers 
  def sign_in(email = "test@test.com", password = "test")
    #save_and_open_page      SAVE IN M
    fill_in :email_or_username, :with => email
    fill_in :password, :with => password
    click_button 'Sign in'
  end

  def sign_up(email = "test@test.com",
              name = "Testname",
              username = "Testusername",
              password = 'test',
              password_confirmation = 'test')


      visit '/newuser'
      expect(page.status_code).to eq(200)
      fill_in :name, :with => name
      fill_in :username, :with => username
      fill_in :email, :with => email
      fill_in :password, :with => password
      fill_in :password_confirmation, :with => password_confirmation
      click_button "Sign up"
  end 

  def user_create(email = "test@test.com",
              name = "Testname",
              username = "Testusername",
              password = 'test',
              password_confirmation = 'test')
  
  u=User.create(  :email => email,
                :name => name,
                :username => name,
                :password => password,
                :password_confirmation => password_confirmation)
  u.save
  u
  end
end