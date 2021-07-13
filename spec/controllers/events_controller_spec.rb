require 'rails_helper'
RSpec.describe EventsController, type: :controller do
    before do
        @user = create(:user)
        @user2 = create(:user, first_name: "First", last_name: "Last", email: "first@gmail.com", city: "San Francisco", state: "CA")
        @event1 = create(:event, user: @user)
        @event2 = create(:event, user: @user2, name: 'Sample Event 2', city: 'San Francisco', state: 'CA')
    end
    
    context "when not logged in" do
        before do
            session[:user_id] = nil
        end

        it "cannot access index" do
            get :index
            expect(response).to redirect_to("/")
        end

        it "cannot access show events" do
            get :show, params: { id:  @event1 }
            expect(response).to redirect_to("/")
        end

        it "cannot access create events" do
            post :create
            expect(response).to redirect_to("/")
        end

        it "cannot access edit events" do
            get :edit, params: { id:  @event1 }
            expect(response).to redirect_to("/")
        end

        it "cannot access update event function" do
            patch :update, params: { id: @event1 }
            expect(response).to redirect_to("/")
        end

        it "cannot access join event function" do
            patch :join, params: { id: @event1 }
            expect(response).to redirect_to("/")
        end

        it "cannot access unjoin event function" do
            delete :unjoin, params: { id: @event1 }
            expect(response).to redirect_to("/")
        end

        it "cannot access comment event function" do
            post :comment, params: { id: @event1 }
            expect(response).to redirect_to("/")
        end

        it "cannot access delete event function" do
            delete :destroy, params: { id: @event1 }
            expect(response).to redirect_to("/")
        end
    end

    context "when signed in as the wrong user" do
        before do
            session[:user_id] = @user.id
        end

        it "cannot access the edit page of another users' events" do
            get :edit, params: { id: @event2 }
            expect(response).to redirect_to("/events")
        end
        
        it "cannot update another users' events" do
            patch :update, params: { id: @event2 }
            expect(response).to redirect_to("/events")
        end

        it "cannot delete another users' events" do
            delete :destroy, params: { id: @event2 }
            expect(response).to redirect_to("/events")
        end
    end
end