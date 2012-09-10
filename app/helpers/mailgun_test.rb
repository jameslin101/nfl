module MailgunTest
  require 'net/pop'
  
  def MailgunTest.post_simple_message
    RestClient.post "https://api:key-5mmeu2g8zute4vlp4z-5eiauz6738jv5"\
    "@api.mailgun.net/v2/fansensus.mailgun.org/messages",
    :from => "Excited User <me@fansensus.mailgun.org>",
    :to => "jameslin101@gmail.com",
    :subject => "Hello",
    :text => "Testing some Mailgun awesomness!"
  end

  def MailgunTest.create_new_mailbox
    RestClient.post "https://api:key-5mmeu2g8zute4vlp4z-5eiauz6738jv5"\
    "@api.mailgun.net/v2/fansensus.mailgun.org/mailboxes",
    :mailbox => "james@fansensus.mailgun.org",
    :password => "secret"
  end 

  def MailgunTest.email_importer
    pop = Net::POP3.new('pop3.mailgun.org')
    pop.start('james@fansensus.mailgun.org', 'secret')            
    if pop.mails.empty?
      puts 'No mail.'
    else
      pop.each_mail do |m|   # or "pop.mails.each ..."  
        puts m.pop
      end
      #m.delete
      puts "#{pop.mails.size} mails popped."
    end
    pop.finish
  end
    
 
end