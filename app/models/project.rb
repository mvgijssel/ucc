class Project < ActiveRecord::Base
  attr_accessible :name





  #--------------- BELOW THIS LINE IS WEAVED INTO THE CLASS

  # replace with has_many relationship + polymorphic!

  after_create :add_groups

  after_destroy :remove_groups

  # return the groups associated with the project
  def groups

    # should be dynamically set
    groups = %w[user moderator admin]

    arr = Array.new

    # replace the items in the groups array with group objects
    groups.map! { |name| UserGroup.find_by_name(group_name name) }

  end

  private

  def group_name name

    # raise error if id is not set
    raise 'id not set' if self.id.nil?

    # return the group name
    "#{self.class.name.to_s}_#{name}_#{self.id}".downcase

  end

  def add_groups

    # should be dynamically set
    groups = %w[user moderator admin]

    groups.each do |name|

      UserGroup.create!(:name => group_name(name))

    end

  end

  def remove_groups

    # should be dynamically set
    groups = %w[user moderator admin]

    groups.each do |name|

      UserGroup.find_by_name(group_name(name)).destroy

    end

  end

end
