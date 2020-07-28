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

    # if /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.match(contactus[:email]) == nil # Check its a valid email
    #   flash.now[:error] = 'Cannot send message invalid email'
    #   render :contactus
    # elsif verify_recaptcha(contactus) && ContactMailer.contact_us(contactus).deliver_now
    #   flash.now[:error] = nil
    #   redirect_to contactus_path, notice: 'Message sent successfully'
    # else
    #   flash.now[:error] = 'Cannot send message'
    #   render :contactus
    # end
  end
end
