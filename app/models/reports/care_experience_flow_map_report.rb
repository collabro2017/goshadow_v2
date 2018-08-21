class CareExperienceFlowMapReport < Report
  
  def save_report_data
    @flow_map_creator = Reports::CareExperienceFlowMapCreator.new(self)
    @flow_map_creator.format_flow_map
    @flow_map_creator.save_start_and_end
    @flow_map_creator.save_data
  end

  def type_humanized
    'Experience Flow Map'
  end
  
  def to_csv
    CSV.generate do |csv|
      csv << [ 'Segment Name', 'Place', 'Persons']
      self.data['segments'].each do |segment|
        segment['references'].each do |reference|
          csv << [ segment['segment_name'], reference['place_name'], reference['persons'].map { |person| person['name'] }.join(', ') ]
        end
      end
    end
  end

end