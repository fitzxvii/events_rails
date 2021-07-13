require 'rails_helper'
feature 'User Settings features ' do
    before do
        @user = create(:user)
        log_in
    end

    feature "User Settings Dashboard" do
        before(:each) do 
            visit "/users/#{@user.id}/edit"
        end

        scenario "visit users edit page" do
            expect(page).to have_field(name: 'first_name')
            expect(page).to have_field(name: 'last_name')
            expect(page).to have_field(name: 'email')
            expect(page).to have_field(name: 'city')
            expect(page).to have_field(name: 'state')
        end

        scenario "inputs filled out correctly" do 
            expect(find_field(name: 'first_name').value).to eq(@user.first_name)
            expect(find_field(name: 'last_name').value).to eq(@user.last_name)
            expect(find_field(name: 'email').value).to eq(@user.email)
            expect(find_field(name: 'city').value).to eq(@user.city)
            expect(find_field(name: 'state').value).to eq(@user.state)   
        end 

        scenario "incorrectly updates information" do
            fill_in 'first_name', with: 'Another Name'      
            fill_in 'email', with: 'incorrect email format'
            click_button 'Update Records'
            expect(current_path).to eq("/users/#{@user.id}/edit")
            expect(page).to have_text("Email is invalid")      
        end   

        scenario "correctly updates information" do 
            fill_in 'first_name', with: 'Test First'
            fill_in 'last_name', with: 'Test Last'
            fill_in 'email', with: 'correct@email.com'
            click_button 'Update Records'
            expect(page).to have_text('Test First')
        end
    end
end