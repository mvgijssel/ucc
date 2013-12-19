class GroupMembership < ActiveRecord::Base

  # depends in what way the relationship is created, through the group or the user
  attr_accessible :user_group_id

  #belongs_to :user, :class_name => 'User'
  belongs_to :user_group, :class_name => 'UserGroup'

end