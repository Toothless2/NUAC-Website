class Post < ApplicationRecord
    validates :body, :title, presence: true
end
