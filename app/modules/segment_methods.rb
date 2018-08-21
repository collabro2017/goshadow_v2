module SegmentMethods

  def text_notes
    notes.where(reference_id: nil)
  end

  def text_note_count
    text_notes.count > 0 ? "#{text_notes.count} Notes" : 'No Notes'  
    text_notes.count == 1 ? "#{text_notes.count} Note" : "#{text_notes.count} Notes"  
  end

  def place_notes
    refs = notes.where.not(reference_id: nil)
    notes = 0
    refs.each do |note|
      if note.reference.type == "Place"
        notes += 1
      end
    end
    notes
  end

  def place_note_count
    place_notes > 0 ? "#{place_notes} Places" : 'No Places'  
    place_notes == 1 ? "#{place_notes} Place" : "#{place_notes} Places"  
  end

  def person_notes
    refs = notes.where.not(reference_id: nil)
    notes = 0
    refs.each do |note|
      if note.reference.type == "Person"
        notes += 1
      end
    end
    notes
  end

  def person_note_count
    person_notes > 0 ? "#{person_notes} People" : 'No People'  
    person_notes == 1 ? "#{person_notes} Person" : "#{person_notes} People"  
  end

  def init_user_segments(organization)
    initiated_user_segments = []
    organization.users.each do |user|
      if !UserSegment.find_by(user_id: user.id, segment_id: self.id)
        initiated_user_segments << UserSegment.new(user_id: user.id, segment_id: self.id)
      end
    end
    initiated_user_segments
  end

end