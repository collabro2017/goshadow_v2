class ReportsController < ApplicationController

  layout 'organization'
  
  def index
    @experience = Experience.find(params['experience_id'])
    @organization = @experience.organization
    @new_report = Report.new
    @reports = @experience.reports.order('created_at DESC');
    respond_to do |format|
      format.js
    end
  end

  def create
    @experience = Experience.find(params['experience_id'])
    @report = @experience.reports.build(report_params)
    if @report.save
      @report.save_report_data
    else
      @errors = format_errors(@report)
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @report = Report.find(params['id'])
    @report.destroy
    render nothing: true
  end

  def open_report
    @report = Report.find(params['report_id'])
    @experience = @report.experience
    respond_to do |format|
      format.csv { send_data @report.to_csv, filename: "#{@report.name.split(' ').join('_')}.csv" }
      format.pdf do
        render pdf: "reports/#{@report.type.underscore}",
        template: "reports/#{@report.type.underscore}",
        footer: {right: 'Page [page] of [topage]' },
        page_size: "letter",
        show_as_html: params.key?('debug')
      end
    end
  end

  private

  def report_params
    params.require(:report).permit(:experience_id, :name, :type, :data, :created_by_id, :segment_id)
  end
  
end