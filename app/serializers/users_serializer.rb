class UserSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :email, :api_token, :api_last_activity, :organization_roles

  def organization_roles
    object.organizations.map { |org| { org_id: org.id, org_role: object.org_role(org) } }
  end
  
end