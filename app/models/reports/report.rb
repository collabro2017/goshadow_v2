class Report < ActiveRecord::Base

  belongs_to :segment
  belongs_to :experience
  belongs_to :created_by, class_name: 'User'
  validates :experience_id, :name, :type, :created_by_id, presence: true

  include TimeHelpers

  TYPES = [ 
    [ 'CareExperienceFlowMapReport', 'Experience Flow Map'],
    [ 'TimeStudyReport', 'Time Study Report'],
    [ 'OpportunityReport', 'Opportunity Report'],
    [ 'AccoladeReport', 'Accolade Report' ],
    [ 'ComprehensiveReport', 'Comprehensive Report' ]
  ]

end