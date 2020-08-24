class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_us.subject
  #
  def contact_us(contact)
    @contact = contact

    mail(to: ENV["CONTACT_EMAIL"], from: @contact[:email], subject: "Website Contact - #{contact[:name]}")
  end

  def contact_us_user_confirm(contact)
    @contact = contact

    mail(to: @contact[:email], from: ENV["CONTACT_EMAIL"], subject: "#{@contact[:name]} thank you for contacting us!")
  end

  helper_method :markdown_body
  
  private
    def markdown_body(text)
        @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
        @markdown.render(text)
    end
end
