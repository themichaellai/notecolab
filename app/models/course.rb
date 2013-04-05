class Course < ActiveRecord::Base
  extend FriendlyId
  friendly_id :number, use: :slugged

  attr_accessible :name, :number
  has_and_belongs_to_many :users, uniq: true
  has_many :notes

  validates :number, uniqueness: true
end
