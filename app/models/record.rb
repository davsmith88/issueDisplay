class Record < ActiveRecord::Base
  belongs_to :recordable, polymorphic: true
  belongs_to :user


  belongs_to :issue

  
  belongs_to :issue_workaround
end
