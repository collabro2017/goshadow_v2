class EmailReportsController < ApplicationController

  def create
    email_is_valid = EmailValidator.valid?(params['email'])
    if email_is_valid
      report = Report.find(params['report_id'])
      ReportMailer.email(current_user, params['email'], params['message'], report).deliver()
      render json: '<div class="alert notice">You have shared your report!</div>'
    else
      render json: '<div class="alert notice">The email address is invalid. Please double-check your submission.</div>'
    end
  end

end