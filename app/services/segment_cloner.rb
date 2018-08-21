class SegmentCloner

  def initialize(experience=nil, segment)
    @segment = segment  
    @new_segment = nil
    @experience = experience
  end

  def run
    copy_segment
    copy_references
    copy_users
  end

  def copy_segment
    @new_segment = @segment.dup
    if @experience
      @new_segment.update(name: ( @segment.name + '( cloned version ) '), experience_id: @experience.id )
    else
      @new_segment.update(sort_order: nil, name: ( @segment.name + '( cloned version ) ') )
    end
  end

  def copy_references
    @segment.references.each { |reference| ReferenceSegment.find_or_create_by(segment_id: @new_segment.id, reference_id: reference.id) }
  end

  def copy_users
    @segment.users.each { |user| UserSegment.find_or_create_by(segment_id: @new_segment.id, user_id: user.id) }
  end

end