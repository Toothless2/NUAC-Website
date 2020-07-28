class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy, :edit]
  before_action :authenticate_user!, except: [:index]
  before_action :check_editor, only: [:edit, :update]

  helper_method :can_edit_record

  def index
    if search_params.nil? || search_params.empty?
      @records = Record.order(score: :desc).where(round: :portsmouth, bowstyle: :recurve, gender: true, achived_at: Date.new(Date.today.year - 1, 9, 1)..Date.new(Date.today.year + 1, 9, 1) )
    else
      @records = Record.order(score: :desc).where(round: search_params[:round], gender: search_params[:mf], bowstyle: search_params[:bowstyle], achived_at: search_params[:from]..search_params[:to])
    end

    @record = Record.new

    respond_to do |format|
      format.html
      format.csv { send_data Record.all.to_csv, filename: "Display-Data-#{DateTime.now}.csv" }
    end
  end

  def edit
  end

  def create
    @record = Record.new(record_params)
    @record.record_name = current_user.record_name

    respond_to do |format|
      if @record.save
        format.html { redirect_to records_path, notice: 'Record was successfully created.' }
        format.json { render records_path, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to records_path, notice: 'Record was successfully updated.' }
        format.json { render records_path, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
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

  private
    def can_edit_record(record)
      user_signed_in? && (current_user.admin || record.record_name.user == current_user)
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
end
