require 'rails_helper'

RSpec.describe Comment, type: :model do
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
        end
        it 'belongs to a user' do
            expect(@comment.user).to eq(@user)
        end
        it 'belongs to a event' do
            expect(@comment.event).to eq(@event)
        end
    end
end
