require 'student_info'

class CoursesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!, only: [:aces, :aces_link, :join, :leave]

  def index
    @courses = Course.paginate page: params[:page], per_page: 20
  end

  def show
    @course = Course.find(params[:id])
    @notes = @course.notes
  end

  def aces
  end

  def aces_link
    aces_res = StudentInfo.new(params[:netid], params[:password]).get_schedule

    if aces_res[:schedule].length == 0
      flash[:error] = 'Wrong credentials/Not enrolled in any classes!'
      redirect_to aces_link_courses_path
    else
      courses_count_init = current_user.courses.count
      aces_res[:schedule].each do |course_data|
        course = Course.find_or_create_by_number(course_data[:number]) do |course|
          course.name = course_data[:name]
          course.number = course_data[:number]
        end
        current_user.courses << course
      end
      found = current_user.courses.count - courses_count_init
      if found > 0
        flash[:success] = "#{pluralize(found, 'course')} in ACES linked!"
      else
        flash[:notice] = "You already belong to all your courses in ACES!"
      end
      redirect_to user_path(current_user)
    end
  end

  def join
    course = Course.find params[:course_id]
    unless current_user.courses.include? course
      current_user.courses << course
      render text: 'Success!'
    else
      render text: 'Already Enrolled!'
    end
  end

  def leave
    course = Course.find params[:course_id]
    if current_user.courses.include? course
      current_user.courses.delete course
      render json: {success: true}
    else
      render json: {success: false, message: 'Error'}
    end
  end

end
