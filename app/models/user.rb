class User < ActiveRecord::Base

  # the accessible attributes
  attr_accessible :name


  #--------------- BELOW THIS LINE IS WEAVED INTO THE CLASS



  # need to be defined!
  has_many :relationships, :dependent => :destroy

  # source determines the foreign key in the relationships table -> group_id
  has_many :member_of, :through => :relationships, :source => :group



  # join a group
  def join group

  end

  # leave a group
  def leave group

  end

end
