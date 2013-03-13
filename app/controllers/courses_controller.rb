require 'student_info'
class CoursesController < ApplicationController
  before_filter :authenticate_user!, only: [:aces, :aces_link]

  def aces
  end

  def aces_link
    aces_res = StudentInfo.new(params[:netid], params[:password]).get_schedule

    if aces_res[:schedule].length == 0
      flash[:error] = 'Wrong credentials/Not enrolled in any classes!'
      redirect_to aces_link_courses_path
    else
      aces_res[:schedule].each do |course_data|
        course = Course.find_or_create_by_number(course_data[:number], name: course_data[:number])
        current_user.courses << course
      end
      flash[:success] = 'Courses in ACES Linked!'
      redirect_to user_path(current_user)
    end
  end
end
