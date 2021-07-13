require 'rails_helper'

RSpec.describe Event, type: :model do
    context "with valid attributes" do
        it "should save" do 
            expect(build(:event)).to be_valid
        end
    end
    context 'relationships' do
        before do 
            @user = create(:user)
            @event = create(:event, user: @user)
            @comment = create(:comment, user: @user, event: @event)
            @attendee = create(:attendee, user: @user, event: @event)
        end
        it 'belongs to a user' do
            expect(@event.user).to eq(@user)
        end
        it 'it has comment' do
            expect(@event.comments).to include(@comment)
        end
        it 'it has attendees' do
            expect(@event.attendees).to include(@attendee)
        end
    end
end
