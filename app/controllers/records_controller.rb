class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy, :edit]
  before_action :authenticate_user!, except: [:index]
  before_action :check_editor, only: [:edit, :update]

  helper_method :can_edit_record

  # GET /records
  # GET /records.json
  def index
    @records = Record.all
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
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

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
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

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    destroyMessage = 'Record was successfully destroyed.'
    if can_edit_record(@record)
        @record.destroy
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
      params.require(:record).permit(:score, :round, :bowstyle, :achived_at, :location)
    end
end
