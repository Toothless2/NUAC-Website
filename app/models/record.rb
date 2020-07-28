require 'csv'
class Record < ApplicationRecord
  belongs_to :record_name

  validates :score, :round, :bowstyle, :achived_at, :gender, presence: true
  enum gender: { male: true, female: false}
  enum bowstyle: { recurve: 0, compound: 1, barebow: 2, longbow: 3, afb: 4 }
  enum round: { portsmouth: 0, bray1: 1, worcester: 2, vegas: 3, fita18: 4, york: 5, hereford: 13, bristol1: 6, bristol2: 7, bristol3: 8, bristol4: 9, bristol5: 10, fita70: 11, other: 12 }
  validates :score, with: :valid_score?

  def name
    self.record_name.name # for some reason canot use an association?
  end

  def self.getAllAcademicYears
    Record.order(achived_at: :desc).map { |m|
      if m.achived_at.month >= 9
        "#{m.achived_at.year}/#{m.achived_at.year + 1}"
      else
        "#{m.achived_at.year - 1}/#{m.achived_at.year}"
      end
    }.uniq
  end

  def self.academicYeartoDateStart(stringAcademic) # first day in academic year
    Date.new(stringAcademic[0..3].to_i, 9, 1)
  end

  def self.academicYeartoDateEnd(stringAcademic) # last day in academic year
    Date.new(stringAcademic[5..].to_i, 8, 1)
  end

  def academic_year_string
    if achived_at.month >= 9
      "#{achived_at.year}/#{achived_at.year + 1}"
    else
      "#{achived_at.year - 1}/#{achived_at.year}"
    end
  end

  def self.to_csv
    attributes = %w{name score round bowstyle achived_at academic_year_string location}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  private
  def valid_score?
    errors.add(:base, 'Score must be > 0 and < Max Score for the round') unless (score.nil? == false) && (score >= 0) && (score <= max_round_score)
  end

  def max_round_score
    case round
    when 'portsmouth', 'vegas', 'fita18'
      600
    when 'bray1', 'worcester'
      300
    when 'york','hereford', 'bristol1', 'bristol2', 'bristol3', 'bristol4', 'bristol5'
      1296
    when 'fita70'
      720
    else
      2 ** ([42].pack('i').size * 16 - 2) - 1
    end
  end
end

# r = Record.new(record_name: RecordName.first, round: :portsmouth, bowstyle: :afb, achived_at: Date.new, location: 'hre')
