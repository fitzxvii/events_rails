require 'rails_helper'

RSpec.describe User, type: :model do
    context "with valid attributes" do 
        it "should save" do 
            expect(build(:user)).to be_valid
        end
        it 'automatically encrypts the password into the password_digest attribute' do
            expect(build(:user).password_digest.present?).to eq(true)
        end 
        it 'email as lowercase' do 
            expect(create(:user, email: 'EMAIL@GMAIL.COM').email).to eq('email@gmail.com')
        end
    end

    context "with invalid attributes should not save if" do 
        it 'first name is blank' do
            expect(build(:user, first_name: '')).to be_invalid
        end
        it 'first name is less than 2 charactes' do
            expect(build(:user, first_name: 'a')).to be_invalid
        end
        it 'last name is blank' do
            expect(build(:user, last_name: '')).to be_invalid
        end
        it 'last name is less than 2 charactes' do
            expect(build(:user, last_name: 'a')).to be_invalid
        end
        it 'city is blank' do
            expect(build(:user, city: '')).to be_invalid
        end
        it 'city is less than 2 charactes' do
            expect(build(:user, city: 'a')).to be_invalid
        end
        it 'state is blank' do
            expect(build(:user, state: '')).to be_invalid
        end
        it 'state is more than 2 characters' do
            expect(build(:user, state: 'aaa')).to be_invalid
        end
        it 'email is blank' do
            expect(build(:user, email: '')).to be_invalid
        end
        it 'email format is wrong' do
            emails = ["@user", "@example.com"]
            emails.each do |email|
                expect(build(:user, email: email)).to be_invalid
            end
        end
        it 'email is not unique' do
            create(:user)
            expect(build(:user)).to be_invalid
        end
        it 'password is blank' do
            expect(build(:user, password: '')).to be_invalid
        end
        it "password doesn't match password_confirmation" do
            expect(build(:user, password_confirmation: 'notpassword')).to be_invalid
        end
    end

    context 'relationships' do
        before(:each) do
            @user = create(:user)
            @event = create(:event, user: @user)
            @comment = create(:comment, user: @user, event: @event)
            @attendee = create(:attendee, user: @user, event: @event)
        end
        it 'it has event' do
            expect(@user.events).to include(@event)
        end
        it 'it has comment' do
            expect(@user.comments).to include(@comment)
        end
        it 'it has events attending' do
            expect(@user.events_attending).to include(@event)
        end
    end
end
