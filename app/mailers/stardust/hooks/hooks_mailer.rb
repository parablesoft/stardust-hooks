class Stardust::Hooks::HooksMailer < ApplicationMailer
  add_template_helper(ActionView::Helpers::NumberHelper)
  def generic_message(to:,subject:,content:, cc:nil, bcc:nil,attachments:[])
    attachments.each do |k,v|
      self.attachments[k] = v
    end
    @content = content
    mail(to: to, cc: cc, subject: subject)
  end

end
