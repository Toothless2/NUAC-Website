class ApplicationController < ActionController::Base
    helper_method :markdown_body


    private
    def markdown_body(text)
        @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
        @markdown.render(text)
    end
end
