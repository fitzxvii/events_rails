require 'rails_helper'
feature 'authentication' do
    before do
        @user = create(:user)
    end
    
    feature "user sign-in" do
        scenario 'visits sign-in page' do
            visit '/'
            expect(page).to have_field(name: 'email')        
            expect(page).to have_field(name: 'password') 
        end
            
        scenario 'logs in user if email/password combination is valid' do
            log_in
            expect(current_path).to eq("/events")
            expect(page).to have_text(@user.first_name)
        end

        scenario 'does not sign in user if email is not found' do
            log_in email: 'wrong email'
            expect(current_path).to eq("/")
            expect(page).to have_text('User does not exist')
        end    

        scenario 'does not sign in user if email/password combination is invalid' do
            log_in password: 'wrong password'
            expect(current_path).to eq("/")      
            expect(page).to have_text('Invalid Combination')
        end
    end

    feature "user to log out" do
        before do 
            log_in 
        end

        scenario 'displays "Log Out" button when user is logged on' do
            expect(page).to have_button('Log Out')
        end

        scenario 'logs out user and redirects to login page' do
            click_button 'Log Out'
            expect(current_path).to eq('/')
        end
    end
end