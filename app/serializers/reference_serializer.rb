class ReferenceSerializer < ActiveModel::Serializer

  attributes :id, :created_at, :updated_at, :name, :type, :organization_id
  
end