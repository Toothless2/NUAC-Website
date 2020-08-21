class AdminPannelController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @users = RecordName.all
  end

  def soft_delete
    rn = RecordName.find(allowed)
    rn.user.destroy

    redirect_to admin_pannel_index_path
  end

  def hard_delete
    rn = RecordName.find(allowed)
    rn.user.destroy
    rn.destroy
    
    redirect_to admin_pannel_index_path
  end

  def io_signups
    en = Signup.first_or_create

    en.enabled = !en.enabled

    en.save

    redirect_to admin_pannel_index_path
  end

  private
  def allowed
    params.required(:id)
  end
end
