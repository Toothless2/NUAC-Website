module ApplicationHelper
    def page_content_helper(pagename)
        PageContent.find_by(page: pagename).nil? ? new_page_content_path(page: pagename) : edit_page_content_path(PageContent.find_by(page: pagename), page: pagename)
    end
end
