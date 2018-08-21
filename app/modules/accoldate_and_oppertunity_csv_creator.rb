module AccoldateAndOppertunityCsvCreator

  def to_csv
    CSV.generate do |csv|
      csv << [ 'Note Created', 'Note Text', 'Reference', 'Reference Name', 'Reference Start Time', 'Reference Duration' ]
      self.data.each do |data_set|
        add_refereces_to_csv(csv, data_set)
      end
    end
  end

  def add_refereces_to_csv(csv, data_set)
    csv << [ data_set['note']['start_time'], data_set['note']['text'] ]
    data_set['references'].each do |reference|
      csv << [ '', '', reference['type'], reference['name'], reference['start'], convert_seconds_to_time(reference['seconds']) ]
    end
  end

end