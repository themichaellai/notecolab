class Courses::UsersController < ApplicationController
  def index
    @course = Course.find params[:course_id]
    @users = @course.users.group(:id).paginate(page: params[:page])
  end
end
