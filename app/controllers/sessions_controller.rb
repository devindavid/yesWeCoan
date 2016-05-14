class SessionsController < ApplicationController

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
        flash[:success] = "That's a good looking photo, #{@user.name}!"
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to profile_path
  end

  def destroy
    if current_user
      current_user.delete_images
      session.delete(:user_id)
      flash[:success] = 'Successfully logged out!'
    end
    redirect_to root_path
  end

end
