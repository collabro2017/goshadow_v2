class AccoladeReport < Report

  include AccoldateAndOppertunityCsvCreator

  def save_report_data
    ordered_notes = Reports::FilterByStatus.run(self, Note::POSITIVE_STATUS)
    self.update(data: ordered_notes)
  end

  def type_humanized
    'Accolade Report'
  end
  
end