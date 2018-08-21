class NoteFormater

  attr_reader :ordered_notes

  def initialize(experience, status, segment=nil)
    @experience = experience
    @segment = segment
    @notes = filter_notes(status)
    @references = @experience.references
    @ordered_notes = []
  end

  def filter_notes(status)
    if @segment && status
      @segment.text_notes.where(status: status)
    elsif @segment && status.nil?
      @segment.text_notes
    else
      @experience.notes.where(status: status)
    end
  end

  def order
    @notes.each do |note|
      note_references = NoteReferenceCollector.call(note.segment, note, 'Person', true)
      @ordered_notes << { 
                        note: {
                          segment_name: note.segment.name,
                          start_time: note.created_at.localtime.strftime("%_m:%M%p"),
                          text: note.text, id: note.id, 
                          total_time: note_total_time(note, note_references),
                          image_url: image_url(note)
                      }, references: format_references(note_references)
                    }
    end
  end

  def format_references(note_references)
    note_references.map { |reference| {
      note_id: reference.id,
      type: Reference.find(reference.reference_id).type,
      start: reference.created_at.localtime.strftime("%_m:%M%p"),
      seconds: reference.seconds,
      name: Reference.find(reference.reference_id).name
      }
    }
  end

  def note_total_time(note, note_references)
    ( note_references.sum('seconds') + note.seconds ) rescue 0
  end

  def image_url(note)
    if note.note_image
      note.note_image.attachment.url
    end
  end

end