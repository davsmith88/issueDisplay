class DepartmentArea < ActiveRecord::Base
  belongs_to :department
  belongs_to :area

  has_many :jobs

  validates_uniqueness_of :department, scope: :area

  self.per_page = 8
end
