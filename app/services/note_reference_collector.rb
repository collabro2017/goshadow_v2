class NoteReferenceCollector

  def self.call(segment, note, reference_type, return_notes)
    @segment = segment
    @note_created = note.created_at
    @reference_type = reference_type
    @return_notes = return_notes
    @reference_ids = []
    @references = []
    self.run
  end

  def self.run
    @segment.notes.where(text: nil).each do |reference|
      timer_start = reference.created_at
      timer_end = timer_start + reference.seconds
      if ( @note_created >= timer_start ) && ( @note_created <= timer_end )
        self.save_references(reference)
      end
    end
    self.return_objects
  end

  def self.save_references(reference)
    if @return_notes
      @references << reference
    else
      @reference_ids << reference.reference_id
    end
  end

  def self.return_objects
    if @return_notes
      @references
    else
      @reference_type.constantize.where(id: @reference_ids)
    end
  end

end