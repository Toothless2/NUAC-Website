class ContactUsController < ApplicationController
  def contactus
  end

  def create
    contactus = params[:contactus]

    begin
      cansend = verify_recaptcha(contactus)
    rescue => exception
      cansend = false
    end

    respond_to do |format|
      if /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.match(contactus[:email]) != nil && cansend && ContactMailer.contact_us(contactus).deliver_now
        format.html { redirect_to contactus_path, notice: 'Record was successfully created.' }
      else
        format.html { render :contactus, notice: 'Failed to send' }
      end
    end
  end
end
