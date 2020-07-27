class ContactUsController < ApplicationController
  def contactus
    @contactus
  end

  def create
    @contactus = params[:contactus]

    if /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.match(contactus[:email]) == nil # Check its a valid email
      flash.now[:error] = 'Cannot send message invalid email'
      render :contactus
    elsif ContactMailer.contact_us(contactus).deliver_now
      flash.now[:error] = nil
      redirect_to contactus_path, notice: 'Message sent successfully'
    else
      flash.now[:error] = 'Cannot send message'
      render :contactus
    end
  end
end
