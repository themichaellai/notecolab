require 'student_info'

class CoursesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!, only: [:aces, :aces_link]

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
          course.name = course_data[:number]
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
end
