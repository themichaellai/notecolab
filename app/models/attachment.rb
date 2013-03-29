class Attachment < ActiveRecord::Base
  attr_accessible :course_id, :user_id, :attached_file, :title
  has_attached_file :attached_file

  belongs_to :note
  belongs_to :user
end
