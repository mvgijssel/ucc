class Page < ActiveRecord::Base
  attr_accessible :content, :title

  # when created -> create entry in SetRelations with:
  # - set_object_id = the created object id
  # - set_id to the current set id
  # - set_container_id to the current container id



  # because of dependent => destroy, will be removed when object removed
  # the as: model indicates a polymorphic relationship
  has_many :collection_relationships, :dependent => :destroy, as: :model

  after_create :create_collection_relationship


  def self.default_scope


    collection_id = 1
    collection_type = 'root'

    joins(:collection_relationships).
        where("collection_relationships.collection_id = ?", collection_id).
        where("collection_relationships.collection_type = ?", collection_type)

  end

  def create_collection_relationship

    collection_id = 1
    collection_type = 'root'

    self.collection_relationships.create!(:collection_id => collection_id, :collection_type => collection_type)

  end

end
