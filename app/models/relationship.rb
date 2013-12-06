class Relationship < ActiveRecord::Base

  # depends in what way the relationship is created, through the group or the user
  attr_accessible :group_id

  #belongs_to :user, :class_name => 'User'
  belongs_to :group, :class_name => 'Group'

end
