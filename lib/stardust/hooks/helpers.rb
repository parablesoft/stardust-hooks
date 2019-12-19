module Stardust::Hooks::Helpers


  def front_end_host
    action_mailer.try(:asset_host,nil)
  end

  def send_email(to:, subject:,content:, cc:nil, bcc:nil)
    Stardust::Hooks::HooksMailer.generic_message(
      to: to,
      subject: subject,
      content: content,
      cc: cc,
      bcc: bcc
    ).deliver_now
  end


  private


  def action_mailer
    config.action_mailer
  end

  def config
    application.config
  end

  def application
    Rails.application
  end
end
