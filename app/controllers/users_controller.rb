class UsersController < ApplicationController
  before_filter :find_user

  def show
    @correct_user = correct_user?
    @courses = @user.courses
  end

  protected
    def find_user
      @user = User.find(params[:id])
    end

    def correct_user?
      current_user == @user
    end

end
