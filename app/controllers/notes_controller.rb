class NotesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def new
    @course = Course.find params[:course_id]
    @note = Note.new
    5.times { @note.attachments.build }
  end

  def create
    @note = Note.new params[:note]
    @course = Course.find(params[:course_id])
    @note.user = current_user
    @note.course = @course
    if @note.save
      flash[:success] = "Note saved!"
      redirect_to course_path(@course)
    else
      flash[:error] = "Note is invalid!"
      render 'new'
    end
  end

  def show
    @note = Note.find params[:id]
  end
end
