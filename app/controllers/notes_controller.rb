class NotesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]

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

  def edit
    @course = Course.find params[:course_id]
    # allows user to keep adding a bunch of attachments, is this cool?
    5.times {@note.attachments.build}
  end

  def update
    @note.update_attributes params[:note]
    if @note.save
      flash[:success] = 'Note updated!'
      redirect_to course_note_path(@note.course, @note)
    else
      flash[:error] = 'Note is invalid!'
      render 'edit'
    end
  end

  private

    def correct_user
      @note = Note.find params[:id]
      unless @note.user == current_user
        flash[:error] = 'You cannot edit this note!'
        redirect_to course_note_path(@note.course, @note)
      end
    end
end
