class Note < ActiveRecord::Base
  attr_accessible :body, :description, :title
  belongs_to :course
  belongs_to :user

  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :title, presence: true
end
