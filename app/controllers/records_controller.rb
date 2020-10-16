class RecordsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :user_confirmed?, only: [:create, :destroy]
  before_action :set_record, only: [ :destroy]
  before_action :check_editor, only: [:edit, :update, :destroy]

  helper_method :can_edit_record

  def index
    if search_params.nil? || search_params.empty?
      @records = Record.order(score: :desc).where(round: :Portsmouth, bowstyle: :Recurve, gender: :Male, achived_at: Date.new(Date.today.year - 1, 9, 1)..Date.new(Date.today.year + 1, 9, 1) )
    else
      @records = Record.order(score: :desc).where(round: search_params[:round], gender: search_params[:mf], bowstyle: search_params[:bowstyle], achived_at: search_params[:from]..search_params[:to])
    end

    @record = Record.new

    if params[:filters] == 'true'
      csvRecords = @records
      name = 'filters'
    elsif params[:adyear] == 'true'
      csvRecords = Record.order(score: :desc).where(achived_at: Record.academicYeartoDateStart(Record.getCurrentAcademicYear())..Record.academicYeartoDateEnd(Record.getCurrentAcademicYear()))
      name = "adyear-#{Record.getCurrentAcademicYear}"
    elsif params[:cu]
      csvRecords = current_user.records
      name = "for-#{current_user.name}"
    else
      csvRecords = Record.all
      name = 'all'
    end

    @test = "no"
    @test2 = false

    # if user does not have a spider/woodpecker thing make one
    if(user_signed_in? && user_confirmed? && SpiderWp.find_by(record_name: current_user.record_name).where(created_at: Record.academicYeartoDateStart(Record.getCurrentAcademicYear())..Record.academicYeartoDateEnd(Record.getCurrentAcademicYear())) == nil)
      @test = "partly"
      wp = SpiderWp.new
      wp.spider_count = 0
      wp.pecker_count = 0
      wp.record_name = current_user.record_name
      @test2 = wp.valid?
      wp.save
      @test = "done"
    end

    @peckers = SpiderWp.order(spider_count: :desc).where(created_at: Record.academicYeartoDateStart(Record.getCurrentAcademicYear())..Record.academicYeartoDateEnd(Record.getCurrentAcademicYear()))

    respond_to do |format|
      format.html
      format.csv { 
        send_data csvRecords.to_csv, filename: "Display-Data-#{name}-#{DateTime.now}.csv"
        # send_data SpiderWp.all.to_csv, filename: "Display-Data-spiders-woodpeckers-#{DateTime.now}.csv"
      }
    end
  end

  def create
    @record = Record.new(record_params)
    @record.record_name = current_user.record_name

    respond_to do |format|
      if verify_recaptcha(@record) && @record.save
        format.html { redirect_to records_path, notice: 'Record was successfully created.' }
      else
        format.html { redirect_to records_path, notice: 'Record addition failed' }
      end
    end
  end

  def destroy
    destroyMessage = 'Record was successfully destroyed.'
    if can_edit_record(@record)
        @record.destroy
        redirect_to records_path
    else
      destroyMessage = 'Cannot delete someone elses record!'
    end
  end

  def increment_spider
    params = spiderwp_params
    spider = SpiderWp.find(params[:id])

    if(!(user_signed_in?) || current_user.id != spider.record_name.user_id)
      redirect_to records_path
      return
    end

    spider.spider_count += (params[:dir]).to_i
    spider.save

    redirect_to records_path
  end

  def increment_wp
    params = spiderwp_params
    wp = SpiderWp.find(params[:id])

    if(!(user_signed_in?) || current_user.id != wp.record_name.user_id)
      redirect_to records_path
      return
    end

    wp.pecker_count += (params[:dir]).to_i
    wp.save

    redirect_to records_path
  end

  private
    def can_edit_record(record)
      committee_user? || (record.record_name.user != nil && record.record_name.user.id == current_user.id)
    end

    def check_editor
      unless can_edit_record(@record)
        redirect_to records_path
      end
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def record_params
      params.require(:record).permit(:score, :round, :bowstyle, :gender, :achived_at )
    end

    def search_params
      params[:search]
    end

    def committee_user?
      super || current_user&.committee?
    end

    def spiderwp_params
      params.permit(:id, :dir)
    end
end
