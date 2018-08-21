class ShadowerSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name

  def id
    object.id
  end
  
end