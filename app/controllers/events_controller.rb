class EventsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :require_admin, except: [:show, :index]
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @events = Event.all
    end

    def show
    end

    def new
        @event = Event.new
    end

    def create 
        @event = Event.new(event_params)

        respond_to do |format|
            if @event.save
                format.html { redirect_to events_path, notice: 'Post was successfully created.' }
            else
                format.html { render :new }
            end
        end
    end

    def edit
    end

    def update
        respond_to do |format|
            if @event.update(event_params)
                format.html { redirect_to events_path, notice: 'Post was successfully created.' }
            else
                format.html { render :edit }
            end
        end
    end

    def destroy
        @event.destroy
        redirect_to events_path
    end

    private
    def event_params
        params.require(:event).permit(:title, :description, :date)
    end

    def set_post
        @event = Event.find(params[:id])
    end
end
