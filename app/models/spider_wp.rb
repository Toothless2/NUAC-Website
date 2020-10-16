class SpiderWp < ApplicationRecord
    belongs_to :record_name

    validates :spider_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :pecker_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    def name
        record_name.name
    end

  def academic_year_string
    if created_at.month >= 9
      "#{created_at.year}/#{created_at.year + 1}"
    else
      "#{created_at.year - 1}/#{created_at.year}"
    end
  end
  
  def self.to_csv
    # Attributes to get
    attributes = %w{id record_name_id name spider_count pecker_count academic_year_string}

    c = CSV.generate(headers: true) do |csv|
      # Headers for the CSV
      csv << ['id', 'user id', 'name', 'spider', 'woodpeckers', 'academic year']

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
