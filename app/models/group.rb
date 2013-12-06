class Group < ActiveRecord::Base
  attr_accessible :name

  # has to be defined, otherwise through relationship doesn't work?
  has_many :relationships, :dependent => :destroy, :foreign_key => 'group_id'

  # members of the group
  has_many :members, :through => :relationships, :source => :user

end
