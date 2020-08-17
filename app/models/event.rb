class Event < ApplicationRecord
    acts_as_votable

    validates :title, :date, :description, presence: true
end
