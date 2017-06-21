class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.company_created.subject
  #
  def company_created(name='annonym')
    @greeting = "Hi #{name}"

    mail to: "muhammadyanaa@gmail.com"
  end
end
