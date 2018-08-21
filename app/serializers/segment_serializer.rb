class SegmentSerializer < ActiveModel::Serializer

  attributes :id, :experience_id, :name, :start_location, :end_location, :notes, :reference_ids, :created_at, :updated_at

  def notes
    object.notes.map do |note|
      NoteSerializer.new(note, root: false)
    end
  end
  
  def reference_ids
    object.references.pluck(:id)
  end

end