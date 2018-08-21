class ComprehensiveReport < Report

  def save_report_data
    @report_creator = Reports::ComprehensiveReportCreator.new(self)
    @report_creator.run
    @report_creator.save
  end

  def type_humanized
    'Comprehensive Report'
  end

  def to_csv
    CSV.generate do |csv|
      csv << [ 'Segment Name', 'Data Type', 'Data point', 'Created By', 'Start Time', 'Duration' ]
      self.data['segments'].each do |segment|
        segment['notes'].each do |note|
          csv << [ segment['segment_name'], note['type'], (note['text'] || note['reference']), note['created_by'], note['created_at_time'], note['duration'] ]
        end
      end
    end
  end

end