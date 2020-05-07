class Stardust::Hooks::HooksMailer < ApplicationMailer
  add_template_helper(ActionView::Helpers::NumberHelper)
  def generic_message(to:,subject:,content:, cc:nil, bcc:nil,attachments:[],from: nil)
    attachments.each do |k,v|
      self.attachments[k] = v
    end
    @content = content
    mail_args = {
      to: to, 
      cc: cc, 
      subject: subject
    }

    mail_args.merge!({
      from: from
    }) unless from.nil?

    mail(mail_args)
  end

end
