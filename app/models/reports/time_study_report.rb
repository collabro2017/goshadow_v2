class TimeStudyReport < Report

  def save_report_data
    time_study_creator = Reports::TimeStudyCreator.new(self)
    time_study_creator.save_people
    time_study_creator.save_places
    time_study_creator.sort
    self.update(data: time_study_creator.data)
  end

  def type_humanized
    'Time Study'
  end

  def to_csv
    CSV.generate do |csv|
      add_people_to_csv(csv)
      csv << []
      add_places_to_csv(csv)
    end
  end
   
  def add_people_to_csv(csv)
    csv << [ 'Person', 'Total Time']
    self.data['people'].each do |people|
      csv << [ people['name'], convert_seconds_to_time(people['time_spent']) ]
    end
    csv << ['Total Time', convert_seconds_to_time(self.data['people_total_time']) ]
  end

  def add_places_to_csv(csv)
    csv << [ 'Place', 'Total Time']
    self.data['places'].each do |place|
      csv << [ place['name'], convert_seconds_to_time(place['time_spent']) ]
    end
    csv << ['Total Time', convert_seconds_to_time(self.data['places_total_time']) ]
  end

end