class ExcitementPageMailer < ActionMailer::Base
  default from: "rhok.ilf@gmail.com"

  def sample_mail email_recipient, excitement_page, url
    @excitement_page = excitement_page
    @url = url
    mail(to: email_recipient, subject: "sample email for #{excitement_page.title}")
  end

end
