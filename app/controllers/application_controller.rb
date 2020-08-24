class ApplicationController < ActionController::Base

    helper_method :markdown_body
    helper_method :admin_user?
    helper_method :page_content_helper
    helper_method :user_confirmed?
    helper_method :can_sign_up?
    helper_method :records_round_format
    helper_method :committee_user?
    helper_method :require_committee
    
    protected
      def can_sign_up?
        Signup.first == nil || Signup.first.enabled == true
      end

      def page_content_helper(pagename)
          PageContent.find_by(page: pagename).nil? ? new_page_content_path(page: pagename) : edit_page_content_path(PageContent.find_by(page: pagename))
      end

      def markdown_body(text)
          @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hardwrap: false), tables: true, superscript: true, highlight: true, strikethrough: true, autolink: true, space_after_headers: true, underline: true)
          @markdown.render(text).html_safe
      end

      def admin_user?
          user_signed_in? && current_user.role.admin
      end

      def committee_user? # To be extended by controllers for granular access
        admin_user?
      end

      def require_admin
          unless admin_user?
            flash[:error] = "You must be an admin to access this"
            redirect_to root_url
          end
      end

      def require_committee
        unless committee_user?
          flash[:error] = "You must be committee to access this!"
          redirect_to request.referrer
        end
      end

      def user_confirmed?
          unless current_user.confirmed?
            redirect_to request.referrer
          end
      end

      def records_round_format
        h = Hash.new
        Record.rounds.each { |k, v| h[k] = k.scan(/[A-Z][a-z]+|[0-9]+/).join(" ") }

        return h
      end
end
