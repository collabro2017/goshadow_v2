module Reports
  class CareExperienceFlowMapCreator

    def initialize(report)
      @report = report
      @experience = @report.experience
      @segments = set_segment
      @formated_data = { segments: [] }
    end

    def save_data
      @report.update(data: @formated_data)
    end

    def set_segment
      @report.segment ? [@report.segment] : SegmentSorter.run(@experience.segments)
    end

    def save_start_and_end
      if @segments.count > 0
        sorted_segments = @segments.sort_by(&:created_at)

        unless sorted_segments.first.notes.blank? # if the first segment has notes
          @formated_data[:start_time] = sorted_segments.first.notes.first.created_at.localtime.strftime("%-I:%M%p on %m/%d/%y")
        else  # if the first segment has no notes, take start from segment
          @formated_data[:start_time] = sorted_segments.first.created_at.localtime.strftime("%-I:%M%p on %m/%d/%y")
        end

        unless sorted_segments.last.notes.blank? # if the last segment has notes
          @formated_data[:end_time] = sorted_segments.last.notes.last.created_at.localtime.strftime("%-I:%M%p on %m/%d/%y")
        else # if the last segment has no notes, take end from segment
          @formated_data[:end_time] = sorted_segments.last.created_at.localtime.strftime("%-I:%M%p on %m/%d/%y")
        end
      end
    end

    def format_flow_map
      @segments.each do |segment|
        @formated_data[:segments] << { 
          segment_name: segment.name,
          created_at_date: segment.created_at.localtime.strftime("%m/%d/%y"),
          created_at_time: segment.created_at.localtime.strftime("%-I:%M%p"),
          positive_note_count: positive_note_count(segment),
          negative_note_count: negative_note_count(segment),
          references: import_notes(segment)
        }
      end
    end

    def import_notes(segment)
      @formated_references = []
      notes = segment.notes.where.not(reference_id: nil).where.not(reference_id: 0)
      check_if_first_note_is_person(notes)
      notes.each do |note|
        save_note(note)
      end
      @formated_references
    end

    def check_if_first_note_is_person(notes)
      if ( notes.first.reference.type == 'Person' rescue false )
        @formated_references << { place_name: 'No Place Specified', persons: [] }
      end
    end

    def save_note(note)
      reference = note.reference
      if reference.type == 'Place'
        @formated_references << { 
          place_name: reference.name, 
          created_at_date: note.created_at.localtime.strftime("%m/%d/%y"), 
          created_at_time: note.created_at.localtime.strftime("%-I:%M%p"),
          created_by: note.user.name,
          seconds: note.seconds,
          persons: [] 
        }
      else
        @formated_references.last[:persons] << { 
          name: reference.name,
          created_at_date: note.created_at.localtime.strftime("%m/%d/%y"), 
          created_at_time: note.created_at.localtime.strftime("%-I:%M%p"),
          created_by: note.user.name,
          seconds: note.seconds
        }
      end
    end

    def positive_note_count(segment)
      segment.notes.where(status: Note::POSITIVE_STATUS).count
    end

    def negative_note_count(segment)
      segment.notes.where(status: Note::NEGATIVE_STATUS).count
    end

  end
end 