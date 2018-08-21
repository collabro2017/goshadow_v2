class OpportunityReport < Report
  
  include AccoldateAndOppertunityCsvCreator
  
  def save_report_data
    ordered_notes = Reports::FilterByStatus.run(self, Note::NEGATIVE_STATUS)
    self.update(data: ordered_notes)
  end

  def type_humanized
    'Opportunity Report'
  end

end