class DepartmentArea < ActiveRecord::Base
  belongs_to :department
  belongs_to :area



  
  belongs_to :business

  has_many :issues

  has_many :jobs
  has_many :locations

  validates_uniqueness_of :department, scope: :area

  self.per_page = 8
end
