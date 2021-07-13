require 'rails_helper'
feature 'Show Events' do
    before do 
        @user = create(:user)
        @user2 = create(:user, first_name: "First", last_name: "Last", email: "first@gmail.com", city: "San Francisco", state: "CA")
        @event1 = create(:event, user: @user2)
        @attendee = create(:attendee, event: @event1, user: @user)
        @comment = create(:comment, user: @user2, event: @event1)
        log_in
    end

    feature 'Main Page' do
        before(:each) do
            visit "/events/#{@event1.id}"
        end

        scenario 'can see all information' do
            expect(page).to have_text("Sample Event 1")
            expect(page).to have_text("Host: First Last")
            expect(page).to have_text("Date: 07/07/2021")
            expect(page).to have_text("Location: Boston, MA")
            expect(page).to have_text("Attendees: 1")
        end

        scenario 'can see lists of attendees' do
            expect(page).to have_text("Fitz Villegas")
            expect(page).to have_text("Boston")
            expect(page).to have_text("MA")
        end

        scenario 'can see people who commented' do
            expect(page).to have_text("First Last says: Sample Comment 1")
        end

        scenario 'can add comment' do
            fill_in 'content', with: "Good event!"
            click_button 'Add Comment'
            expect(page).to have_text("Fitz Villegas says: Good event!")
        end
    end
end