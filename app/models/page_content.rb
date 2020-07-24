class PageContent < ApplicationRecord
    validates :page, :body, presence: true
end
