class MailgunController < ActionController::Base
  
  def incoming_mail
    
    MailgunTest.post_simple_message
    raise params.inspect
    # see if the message is spam:
    # is_spam = request.form['X-Mailgun-SFlag'] == 'Yes'
    # 
    # # access some of the email parsed values:
    # request.form['From']
    # request.form['To']
    # request.form['subject']
    # 
    # # stripped text does not include the original (quoted) message, only what
    # # a user has typed:
    # request.form['stripped-text']
    # request.form['stripped-signature']

    # enumerate through all attachments in the message and save
    # them to disk with their original filenames:
    # for attachment in request.files.values():
    #     attachment.filename
    #     data = attachment.stream.read()
    #     with open(attachment.filename, "w") as f:
    #         f.write(data)
    # 
    # return "Ok"
  end
  
end
