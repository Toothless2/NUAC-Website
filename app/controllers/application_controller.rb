class ApplicationController < ActionController::Base
    include ApplicationHelper
    
    helper_method :markdown_body
    helper_method :admin_user?
    
    private
    def markdown_body(text)
        @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
        @markdown.render(text)
    end

    def admin_user?
        return user_signed_in? && current_user.admin
    end

    def require_admin
        unless admin_user?
          flash[:error] = "You must be an admin to access this"
          redirect_to root_url
        end
    end
end
