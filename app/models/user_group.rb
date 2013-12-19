class UserGroup < ActiveRecord::Base

  attr_accessible :name

  # has to be defined, otherwise through relationship doesn't work?
  has_many :group_memberships, :dependent => :destroy

  # members of the group
  has_many :members, :through => :group_memberships, :source => :user

end
