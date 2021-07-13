require 'rails_helper'
feature 'Users features' do
    before do
        @user = create(:user)
    end

    feature "login-register page" do
        before(:each) do 
            visit '/'
        end

        scenario 'visits page' do    
            expect(page).to have_field(name: 'user[first_name]')
            expect(page).to have_field(name: 'user[last_name]')
            expect(page).to have_field(name: 'user[email]')
            expect(page).to have_field(name: 'user[city]')
            expect(page).to have_field(name: 'user[state]')
            expect(page).to have_field(name: 'user[password]')
            expect(page).to have_field(name: 'user[password_confirmation]')    
            expect(page).to have_field(name: 'email')        
            expect(page).to have_field(name: 'password') 
        end

        scenario "with improper inputs in register form, redirects back to login-register page and shows validations" do
            click_button 'Register'
            expect(current_path).to eq('/')
            expect(page).to have_text("can't be blank")
        end

        scenario "with proper inputs in register form, create user and redirects to events page" do 
            fill_in 'user[first_name]', with: 'Test'
            fill_in 'user[last_name]', with: 'User'
            fill_in 'user[email]', with: 'test@gmail.com'
            fill_in 'user[city]', with: 'Miami'
            page.select 'FL', from: 'user[state]'
            fill_in 'user[password]', with:  'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button 'Register'
            expect(current_path).to eq("/events")
        end

        scenario "with improper email input in login form, redirects back to login-register page and shows error" do
            fill_in 'email', with: 'test_at_gmail.com'
            click_button 'Log In'
            expect(current_path).to eq('/')
            expect(page).to have_text("User does not exist")
        end

        scenario "with wrong password in login form, redirects back to login-register page and shows error" do
            fill_in 'email', with: 'fitz@gmail.com'
            fill_in 'password', with: 'wrong_password'
            click_button 'Log In'
            expect(current_path).to eq('/')
            expect(page).to have_text("Invalid Combination")
        end

        scenario "with proper inputs in login form, it redirects to events page" do
            fill_in 'email', with: 'fitz@gmail.com'
            fill_in 'password', with: 'password'
            click_button 'Log In'
            expect(current_path).to eq('/events')
        end
    end
end