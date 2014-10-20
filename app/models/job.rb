class Job < ActiveRecord::Base
  belongs_to :department_area

  has_many :steps

  validates :name, presence: {message: "A Job must have a name"}


  TYPES = ['cleaning', 'maintenance', 'operational']
end
