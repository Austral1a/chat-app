class SessionsController < ApplicationController
  before_action :logged_in_redirect?, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to root_path
    else
      flash.now[:error] = "There was something wrong with your password or username"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been logged out"
    redirect_to root_path
  end

  private

    def logged_in_redirect?
      if logged_in?
        flash[:error] = "You have already logged in"
        redirect_to root_path
      end
    end
end
