class AdminPannelController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @users = User.all
  end

  def soft_delete
    u = User.find(allowed)
    u.destroy

    redrect_to admin_pannel_index_path
  end

  def hard_delete
    u = User.find(allowed)

    u.record_name.destroy
    u.destroy
    
    redrect_to admin_pannel_index_path
  end

  private
  def allowed
    params.required(:id)
  end
end
