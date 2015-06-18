class UserMailer < ActionMailer::Base
  default from: "asg.sending@gmail.com"

  def send_to_client(session, subject, body, whom = nil)
    @body = body + session
    mail_to = "asg.sending@gmail.com"
    unless whom.nil?
      case whom
        when 'client'
          clients = Client.all_alkp(session)
          clients.each do |client|
            unless client.email.nil?
              mail_to += ", " + client.email if ( client.email.length > 10 )
            end
          end
        when 'staff'

        when 'my_list'

      end

    else
      mail_to += ", " + session
    end
    @url  = 'http://example.com/login'
    mail(to: mail_to, subject: subject)
  end
end
