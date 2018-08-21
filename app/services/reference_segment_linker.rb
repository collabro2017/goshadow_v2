class ReferenceSegmentLinker

  def initialize(segment, group_ids, reference_ids)
    @segment = segment
    @group_ids = group_ids || []
    @reference_ids = reference_ids || []
    @newly_added_references = []
  end

  def run
    by_group
    bulk_add_references
    @newly_added_references
  end

  def by_group
    @group_ids.each do |group_id|
      group = Group.find(group_id)
      group.references.each do |reference|
        create_record(reference.id)
      end
    end
  end

  def bulk_add_references
    @reference_ids.each do |reference_id|
      create_record(reference_id)
    end
  end

  def create_record(reference_id)
    reference_segment = ReferenceSegment.create(segment_id: @segment.id, reference_id: reference_id)
    if reference_segment.save
      @newly_added_references << reference_segment.reference
    end
  end

end