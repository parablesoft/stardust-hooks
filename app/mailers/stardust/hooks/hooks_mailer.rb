class Stardust::Hooks::HooksMailer < ApplicationMailer
  add_template_helper(ActionView::Helpers::NumberHelper)
  def generic_message(to:,subject:,content:, cc:nil, bcc:nil)
    @content = content
    mail(to: to, cc: cc, subject: subject)
  end

end
