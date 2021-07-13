class UsersController < ApplicationController
    skip_before_action :require_login, only: [:index, :create, :login, :destroy]
    before_action :check_user, only: [:edit, :update]

    def index
    end

    def create
        @new_user = User.create(user_params)
        if @new_user.valid?
            session[:user_id] = @new_user.id
            redirect_to '/events'
        else
            flash[:errors] = @new_user.errors.full_messages
            redirect_to '/'
        end
    end
  
    def login
        @user = User.find_by(email: params[:email])
        if @user.nil?
            flash[:errors] = ["User does not exist"]
            return redirect_to '/'
        else
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                return redirect_to '/events'
            else
                flash[:errors] = ["Invalid Combination"]
                return redirect_to '/'
            end
        end
    end

    def edit
    end

    def update
        @user = User.find(current_user.id)
        @user.first_name = params['first_name']
        @user.last_name = params['last_name']
        @user.email = params['email']
        @user.city = params['city']
        @user.state = params['state']
        if @user.valid?
            @user.save
            redirect_to '/events'
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to "/users/#{current_user.id}/edit"
        end
    end

    def destroy
        reset_session
        redirect_to '/'
    end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
        end

        def check_user
            if current_user != User.find(params[:id])
                redirect_to "/events"
            end
        end
end
