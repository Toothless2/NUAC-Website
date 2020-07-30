class ApplicationController < ActionController::Base

    helper_method :markdown_body
    helper_method :admin_user?
    helper_method :page_content_helper
    
    private
    def page_content_helper(pagename)
        PageContent.find_by(page: pagename).nil? ? new_page_content_path(page: pagename) : edit_page_content_path(PageContent.find_by(page: pagename))
    end

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
