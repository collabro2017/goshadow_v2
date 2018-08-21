class ExperienceSerializer < ActiveModel::Serializer
  
  attributes :id, :created_at, :updated_at, :name, :organization_id, :location, :description, :published, :segments, :shadowers

  def segments
    user = User.find(scope[:user_id])
    is_coordinator = scope[:is_coordinator]
    object.segments.where(archived: false).map do |segment|
      SegmentSerializer.new(segment, root: false)
    end
  end

  def shadowers
    object.users.map do |user|
      ShadowerSerializer.new(user, root: false)
    end
  end

end