require 'rails_helper'
feature 'Events' do
    before(:each) do 
        @user = create(:user)
        @user2 = create(:user, first_name: "First", last_name: "Last", email: "first@gmail.com", city: "San Francisco", state: "CA")
        @event1 = create(:event, user: @user)
        @event2 = create(:event, user: @user2, name: 'Sample Event 2', city: 'San Francisco', state: 'CA')
        @event3 = create(:event, user: @user2, name: 'Sample Event 3', city: 'Houston', state: 'TX')
        @event4 = create(:event, user: @user2, name: 'Sample Event 4')
        @attendee = create(:attendee, event: @event2, user: @user)
    end
    
    feature "Main Dashboard" do
        before(:each) do 
            log_in
        end

        scenario 'can view header' do
            expect(page).to have_text('Welcome, Fitz')
            expect(page).to have_link('Edit My Profile')
            expect(page).to have_button('Log Out')
        end

        scenario "can view owner's event" do
            expect(page).to have_text('Sample Event 1')
            expect(page).to have_text('Fitz Villegas')
            expect(page).to have_link('Edit')
            expect(page).to have_link('Delete')
        end

        scenario "can delete events that a user owns" do
            click_link 'Delete'
            expect(current_path).to eq("/events") 
            expect(page).to_not have_text('Sample Event 1')
        end

        scenario "cannot delete other's events" do
            page.driver.submit :delete, "/events/#{@event4.id}/delete", {}
            expect(page).to have_text('Sample Event 4')
        end

        scenario "can view events in local state" do
            expect(page).to have_text('Sample Event 4')
            expect(page).to have_text('Boston')
        end

        scenario "can view events in other states" do
            expect(page).to have_text('Sample Event 2')
            expect(page).to have_link('Cancel')
            expect(page).to have_text('Sample Event 3')
        end

        scenario "can create event " do
            fill_in "event[name]", with: "New Event"
            fill_in "event[date]", with: "2022/07/07"
            fill_in "event[city]", with: "Boston"
            page.select 'MA', from: 'event[state]'
            click_button "Add Event"
            expect(current_path).to eq("/events")    
            expect(page).to have_text('New Event')
        end

        scenario "only future-dated events should be added" do
            fill_in "event[name]", with: "New Event"
            fill_in "event[date]", with: "2020/07/07"
            fill_in "event[city]", with: "Boston"
            page.select 'MA', from: 'event[state]'
            click_button "Add Event"
            expect(current_path).to eq("/events")    
            expect(page).to have_text('must be on a future date')
        end

        scenario "can join all events" do
            page.all('a', text: 'Join').each do |join|
                join.click
                expect(current_path).to eq("/events")  
                expect(page).to have_text("You joined successfully!")
            end
        end

        scenario "can cancel event" do
            click_link 'Cancel'
            expect(current_path).to eq("/events") 
            expect(page).to have_text("You unjoined successfully!")
        end

        scenario "can go to edit events page" do
            click_link 'Edit'
            expect(current_path).to eq("/events/#{@event1.id}/edit")
        end
    end
end