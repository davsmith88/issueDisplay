class Item < ActiveRecord::Base

  belongs_to :department_area
  belongs_to :type, polymorphic: true
  
  scope :all_problems, -> { where(type_type: "Problem") }
  scope :all_issues, -> { where(type_type: "Issue") }

  scope :p_attr_name_id, -> { all_problems.pluck(:name, :id) }
  scope :i_attr_name_id, -> { all_issues.pluck(:name, :id) }

  validates :name, presence: {message: "Issue needs to have a name"}
  validates :description, presence: {message: "Issue needs to have a description"}

  # def build_associable(params)
  #   self.type = type_type.constantize.new(params)
  # end
  self.per_page = 5

  protected

  def self.search(search, search_col, page)
      search_condition = "%#{search}%"
      case search_col
        when "id"
          condition = ['id = ?', search]
        when "name"
          condition = ['name like ?', search_condition]
        when "description"
          condition = ['description like ?', search_condition]
        when "name|description"
          condition = ['name like ? OR description like ?', search_condition, search_condition]
        else
          condition = ['name like ?', search_condition]
      end
      
      Item.order('name').where(condition).paginate(:page => 1)
      # paginate per_page: 5, page: page, conditions: condition, order: 'name'
    
    end
end
