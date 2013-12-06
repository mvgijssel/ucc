class Page < ActiveRecord::Base
  attr_accessible :content, :title

  # when created -> create entry in SetRelations with:
  # - set_object_id = the created object id
  # - set_id to the current set id
  # - set_container_id to the current container id


  # polymorphic relations??

  has_many :set_relations, :dependent => :destroy, :foreign_key => 'set_object_id'

  after_create :create_set_relation


  #def self.default_scope
  #
  #  set_id = UCC::Request.request[:id]
  #
  #  set_container_id = 1
  #
  #  joins(:set_relations).
  #      where("set_relations.set_id = ?", set_id).
  #      where("set_relations.set_container_id = ?", set_container_id)
  #
  #end

  def create_set_relation

    set_id = 1

    set_container_id = 1

    self.set_relations.create!(:set_id => set_id, :set_container_id => set_container_id)

  end

end
