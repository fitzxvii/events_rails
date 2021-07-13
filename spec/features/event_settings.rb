require 'rails_helper'
feature 'Event Settings features ' do
    before do
        @user = create(:user)
        @event1 = create(:event, user: @user)
        log_in
    end

    feature "Event Settings page" do
        before(:each) do 
            visit "/events/#{@event1.id}/edit"
        end
        
        scenario "visit event edit page" do
            expect(page).to have_field(name: 'name')
            expect(page).to have_field(name: 'date')
            expect(page).to have_field(name: 'city')
            expect(page).to have_field(name: 'state')
        end

        scenario "inputs filled out correctly" do 
            expect(find_field(name: 'name').value).to eq(@event1.name)
            expect(find_field(name: 'date').value).to eq(@event1.date.strftime("%Y-%m-%d"))
            expect(find_field(name: 'city').value).to eq(@event1.city)
            expect(find_field(name: 'state').value).to eq(@event1.state)   
        end

        scenario "correctly updates information" do 
            fill_in 'name', with: 'Edited Event 1'
            fill_in 'date', with: '2022-07-19'
            click_button 'Update Event'
            expect(page).to have_text('Edited Event 1')
            expect(page).to have_text('2022-07-19')
        end
    end
end