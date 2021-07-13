class EventsController < ApplicationController
    before_action :require_login
    before_action :check_user, only: [:edit, :update, :destroy]

    def index
        @nearest_events = Event.where("state = ?", current_user.state)
        @other_events = Event.where("state != ?", current_user.state)
    end

    def create
        @new_event = Event.new(event_params)
        @new_event.user = current_user
        if @new_event.valid?
            @new_event.save
            flash[:success] = ['Event added Successfully!']
            redirect_to '/events'
        else
            flash[:errors] = @new_event.errors.full_messages
            redirect_to '/events'
        end
    end
    
    def edit
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])
        @event.name = params['name']
        @event.date = params['date']
        @event.city = params['city']
        @event.state = params['state']
        if @event.valid?
            @event.save
            redirect_to '/events'
        else
            flash[:errors] = @event.errors.full_messages
            redirect_to "/events/#{params[:id]}/edit"
        end
    end

    def join
        @event = Event.find(params[:id])
        new_attendee = Attendee.new(event: @event, user: current_user)
        if new_attendee.valid?
            new_attendee.save
            flash[:success] = ["You joined successfully!"]
            redirect_to '/events'
        else 
            flash[:errors] = ["Something went wrong"]
            redirect_to '/events'
        end
    end

    def unjoin
        @event = Event.find(params[:id])
        attendee = Attendee.find_by(event: @event, user: current_user)
        if attendee.valid?
            attendee.destroy
            flash[:success] = ["You unjoined successfully!"]
            redirect_to '/events'
        else 
            flash[:errors] = ["Something went wrong"]
            redirect_to '/events'
        end
    end 

    def show
        @event = Event.find(params[:id])
        @attendees = @event.users
        @comments = @event.comments
    end

    def comment
        @event = Event.find(params[:id])
        comment = Comment.new(event: @event, user: current_user)
        comment.content = params['content']
        if comment.valid?
            comment.save
            redirect_to "/events/#{params[:id]}"
        else
            flash[:errors] = comment.errors.full_messages
            redirect_to "/events/#{params[:id]}"
        end
    end

    def destroy
        @event = Event.find(params[:id])
        if @event.valid? 
            @event.destroy
            flash[:success] = ['Event deleted successfully!']
            redirect_to '/events'
        else
            flash[:errors] = ['Something went wrong.']
            redirect_to '/events'
        end
    end

    private
        def event_params
            params.require(:event).permit(:name, :date, :state, :city)
        end

        def check_user
            @event = Event.find(params[:id])
            if current_user != @event.user
                redirect_to "/events"
            end
        end
end
