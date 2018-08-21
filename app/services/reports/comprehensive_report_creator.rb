module Reports
  class ComprehensiveReportCreator

    def initialize(report)
      @report = report
      @experience = report.experience
      @segments = set_segments
      @formated_data = { segments: [], experience_name: @experience.name, segment_names: segment_names }
    end

    def set_segments
      @report.segment ? [@report.segment] : SegmentSorter.run(@experience.segments)
    end

    def segment_names
      @segments.map { |segment| segment.name }
    end

    def run
      @segments.each do |segment|
        @formated_data[:segments] << format_segment(segment)
      end
    end

    def format_segment(segment)
      { 
        segment_name: segment.name, 
        created_at_time: segment.created_at.localtime.strftime("%-I:%M%p"),
        created_at_date: segment.created_at.localtime.strftime("%m/%d/%y"),
        notes: format_notes(segment) 
      }
    end

    def format_notes(segment)
      notes = []
      segment.notes.each do |note|
        notes << {
          type: note.type, 
          text: note.text, 
          status: note.status, 
          reference: (note.reference.name rescue ''),
          duration: note.duration, 
          created_by: note.user.name,
          created_at_time: note.created_at.localtime.strftime("%-I:%M%p"),
          created_at_date: note.created_at.localtime.strftime("%m/%d/%y"),
          image_url: (note.note_image.attachment.url rescue nil),
          text_note_places: text_note_references(segment, note, 'Place'),
          text_note_persons: text_note_references(segment, note, 'Person')
        }
      end
      notes
    end

    def text_note_references(segment, note, type)
      if note.type == 'Note'
        references = NoteReferenceCollector.call(segment, note, type, false)
        references.map { |reference| reference.name }.uniq
      else
        []
      end
    end

    def save
      @report.data = @formated_data
      @report.save
    end

  end
end
