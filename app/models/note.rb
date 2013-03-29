class Note < ActiveRecord::Base
  attr_accessible :body, :description, :title, :attachments_attributes
  belongs_to :course
  belongs_to :user
  has_many :attachments
  accepts_nested_attributes_for :attachments

  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :title, presence: true
end
