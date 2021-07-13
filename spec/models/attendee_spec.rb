require 'rails_helper'

RSpec.describe Attendee, type: :model do
    before(:each) do 
        @user = create(:user)
        @event = create(:event, user: @user)
    end
    context "with valid attributes" do
        it "should save" do 
            expect(build(:attendee, user: @user, event: @event)).to be_valid
        end
    end
    context 'relationships' do
        before(:each) do
            @attendee = create(:attendee, user: @user, event: @event)
        end
        it 'belongs to a user' do
            expect(@attendee.user).to eq(@user)
        end
        it 'belongs to a event' do
            expect(@attendee.event).to eq(@event)
        end
    end
end
