class Course < ActiveRecord::Base
  attr_accessible :name, :number
  has_and_belongs_to_many :users, uniq: true

  validates :number, uniqueness: true
end
