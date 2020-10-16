class RecordName < ApplicationRecord
  belongs_to :user, optional: true
  has_many :records, dependent: :destroy
  has_many :spider_wps, dependent: :destroy
end
