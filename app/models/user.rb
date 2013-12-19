class User < ActiveRecord::Base

  # the accessible attributes
  attr_accessible :name


  #--------------- BELOW THIS LINE IS WEAVED INTO THE CLASS



  # need to be defined!
  has_many :group_memberships, :dependent => :destroy

  # source determines the foreign key in the relationships table -> group_id
  has_many :member_of, :through => :group_memberships, :source => :user_group


end
