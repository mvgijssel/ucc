class CollectionRelationship < ActiveRecord::Base

  # :model_id, :model_type are set through association
  # only collection id and type can be set through mass assignment
  attr_accessible :collection_id, :collection_type

  # model indicates the model_id and model_type in the database
  belongs_to :model, polymorphic: true

end
