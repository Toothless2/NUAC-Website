class Post < ApplicationRecord
    validates :body, :title, :tag, presence: true
    validates :tag, inclusion: { in: %w(general social competition announcement) }
end
