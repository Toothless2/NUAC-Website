class AdminPannelController < ApplicationController
  before_action :authenticate_user!
  before_action :require_committee
  before_action :get_rn, only: [:soft_delete, :hard_delete]

  def index
    @users = RecordName.all
    @record = Record.new
  end

  def soft_delete
    @rn.user.destroy

    redirect_to admin_pannel_index_path
  end

  def hard_delete
    @rn.user.destroy
    @rn.destroy
    
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

  def user_update_role
    @user = User.find(allowed)

    if (@user == nil)
      return
    end

    if(@user.role.name == 'committee')
      @user.role = Role.find_by(name: 'user')
    else
      @user.role = Role.find_by(name: 'committee')
    end

    @user.save

    redirect_to admin_pannel_index_path
  end

  private
    def committee_user?
      admin_user? || current_user&.committee?
    end

    def allowed
      params.required(:id)
    end

    def record_params
      params.require(:record).permit(:record_name_id, :score, :round, :bowstyle, :gender, :achived_at)
    end

    def get_rn
      @rn = RecordName.find(allowed)
    end
end
