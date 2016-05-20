class MessageMailer < ActionMailer::Base

  default from: "Your Mailer <noreply@yourdomain.com>"
  default to: "Your Name <emojisentiment@gmail.com>"

  def new_message(message)
    @message = message

    mail subject: "Message from #{message.name}"
  end

end
