class UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = 'This a list of users'
    else
      redirect_to new_user_session_path
    end
  end
end
