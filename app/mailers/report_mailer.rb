class ReportMailer < ApplicationMailer

  def email(sender, email, message, report)
    @sender = sender
    @email = email
    @message = message
    @report = report
    mail(to: @email, subject: "#{@sender.name} sent you the #{@report.name} from GoShadow")
  end

end