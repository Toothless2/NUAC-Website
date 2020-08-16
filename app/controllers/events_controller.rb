class EventsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :require_admin, except: [:show, :index, :event_response]
    before_action :set_post, only: [:show, :edit, :update, :destroy, :event_response]
    before_action :user_confirmed?, only: [:event_response]
    before_action :can_respond?, only: [:event_response]

    helper_method :date_suffix

    def index
        @events = Event.where('date > ?', DateTime.yesterday)
    end

    def show
        @going_users = User.where(id: @event.find_votes_for(vote_scope: :going).select(:voter_id)).select(:name)
        @mabey_users = User.where(id: @event.find_votes_for(vote_scope: :mabey).select(:voter_id)).select(:name)
        @cant_users = User.where(id: @event.find_votes_for(vote_scope: :cant).select(:voter_id)).select(:name)
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

    def event_response
        @event.unliked_by current_user, vote_scope: :going
        @event.unliked_by current_user, vote_scope: :mabey
        @event.unliked_by current_user, vote_scope: :cant

        case params[:event_resonse]
            when 'going'
                going
            when 'mabey'
                mabey
            when 'cant'
                cant
        end

        redirect_to request.referrer
    end

    private
    def event_params
        params.require(:event).permit(:title, :description, :date)
    end

    def set_post
        @event = Event.find(params[:id])
    end

    def going
        @event.liked_by current_user, vote_scope: :going
    end

    def mabey
        @event.liked_by current_user, vote_scope: :mabey
    end

    def cant
        @event.liked_by current_user, vote_scope: :cant
    end

    def can_respond?
        unless @event.date >= DateTime.now
            redirect_to request.referrer
        end
    end

    def date_suffix(d)
        {1:'st',2:'nd',3:'rd'}.get(d%10, 'th')
    end
end
