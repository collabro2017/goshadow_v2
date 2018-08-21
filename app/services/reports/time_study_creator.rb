module Reports
  class TimeStudyCreator

    attr_reader :data

    def initialize(report)
      @report = report
      @experience = @report.experience
      @segment = @report.segment
      @data = { people: [], places: [], people_total_time: 0, places_total_time: 0 }
      @notes = filter_notes
    end

    def filter_notes
      if @segment
        Note.where(segment_id: @segment.id)
      else
        Note.where(segment: @experience.segments)
      end
    end

    def save_people
      persons = Person.where(id: @notes.pluck(:reference_id) )
      persons.each do |person|
        total_shadowing_time = @notes.where(reference_id: person.id).sum(:seconds) || 0
        @data[:people_total_time] += total_shadowing_time
        @data[:people] << { id: person.id, name: person.name, time_spent: total_shadowing_time }
      end
    end

    def save_places
      places = Place.where(id: @notes.pluck(:reference_id) )
      places.each do |place|
        total_shadowing_time = @notes.where(reference_id: place.id).sum(:seconds) || 0
        @data[:places_total_time] += total_shadowing_time
        @data[:places] << { id: place.id, name: place.name, time_spent: total_shadowing_time }
      end
    end

    def sort
      @data[:people].sort_by! { |person| person[:time_spent] }.reverse!
      @data[:places].sort_by! { |place| place[:time_spent] }.reverse!
    end
      
  end
end