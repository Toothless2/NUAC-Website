class AdminPannelController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @users = RecordName.all
    @record = Record.new
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

  def admin_save_record
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        format.html { redirect_to admin_pannel_index_path, notice: 'Record was successfully created.' }
      else
        format.html { redirect_to admin_pannel_index_path, notice: 'Record addition failed' }
      end
    end
  end

  private
  def allowed
    params.required(:id)
  end

  def record_params
    params.require(:record).permit(:record_name_id, :score, :round, :bowstyle, :gender, :achived_at)
  end
end
