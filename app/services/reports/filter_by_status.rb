module Reports
  class FilterByStatus

    attr_reader :data

    def self.run(report, status)
      @report = report
      @note_formater = NoteFormater.new(@report.experience, status, @report.segment)
      @note_formater.order
      @note_formater.ordered_notes
    end

  end
end