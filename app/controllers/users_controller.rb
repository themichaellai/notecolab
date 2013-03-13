class UsersController < ApplicationController
  before_filter :find_user
  before_filter :correct_user, only: [:aces_link]

  def show
    @courses = @user.courses
  end

  protected
    def find_user
      @user = User.find(params[:id])
    end

    def correct_user
      unless current_user == @user
        flash[:alert] = "You're not the right user!"
        redirect_to root_path
      end
    end

end
