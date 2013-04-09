class UsersController < ApplicationController
  before_filter :find_user

  def show
    @correct_user = correct_user? @user
    @courses = @user.courses
  end

  protected
    def find_user
      @user = User.find(params[:id])
    end

    def correct_user?(user)
      current_user == user
    end

end
