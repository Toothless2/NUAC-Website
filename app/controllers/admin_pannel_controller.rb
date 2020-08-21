class AdminPannelController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @users = RecordName.all
  end

  def soft_delete
    rn = RecordName.find(allowed)
    rn.user.destroy

    redrect_to admin_pannel_index_path
  end

  def hard_delete
    rn = RecordName.find(allowed)
    rn.user.destroy
    rn.destroy
    
    redrect_to admin_pannel_index_path
  end

  private
  def allowed
    params.required(:id)
  end
end
