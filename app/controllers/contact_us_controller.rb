class ContactUsController < ApplicationController
  def contactus
    @contactus = Contact.new
  end

  def create
    @contactus = Contact.new(params[:contact])
    @contactus.request = request
    if @contactus.deliver
      flash.now[:error] = nil
      redirect_to contactus_path, notice: 'Message sent successfully'
    else
      flash.now[:error] = 'Cannot send message'
      render :contactus
    end
  end
end
