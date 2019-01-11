class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  mail to: "sufo10@macr2.com", subject: "お問い合わせの確認メール"
end
