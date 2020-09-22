require 'csv'
class Record < ApplicationRecord
  belongs_to :record_name

  validates :score, :round, :bowstyle, :achived_at, :gender, presence: true
  enum gender: { Male: "Male", Female: "Female" }
  enum bowstyle: { Recurve: 0, Compound: 1, Barebow: 2, Longbow: 3, AFB: 4 }
  enum round: { Portsmouth: 0, Bray1: 1, Worcester: 2, Vegas: 3, Fita18: 4, York: 5, Hereford: 13, Bristol1: 6, Bristol2: 7, Bristol3: 8, Bristol4: 9, Bristol5: 10, Fita70: 11, Fita60: 12, Metric1: 13, Metric2: 14, Metric3: 15, Metric4: 16, Metric5: 17, LongMetric: 18, LongMetric1: 19, LongMetric2: 20, LongMetric3: 21, LongMetric4: 22, LongMetric5: 23, ShortMetric: 24, ShortMetric1: 25, ShortMetric2: 26, ShortMetric3: 27, ShortMetric4: 28, ShortMetric5: 29, HalfMetric1: 30, HalfMetric2: 31, HalfMetric3: 32, HalfMetric4: 33, HalfMetric5: 34, Other: 35 }
  validates :score, with: :valid_score?

  def name
    self.record_name.name # for some reason canot use an association?
  end

  def self.getAllAcademicYears
    Record.order(achived_at: :desc).map { |m|
      m.academic_year_string
    }.uniq
  end

  def self.academicYeartoDateStart(stringAcademic) # first day in academic year
    Date.new(stringAcademic[0..3].to_i, 9, 1)
  end

  def self.academicYeartoDateEnd(stringAcademic) # last day in academic year
    Date.new(stringAcademic[5..].to_i, 8, -1)
  end

  def self.getCurrentAcademicYear
    if Date.today.month >= 9
      "#{Date.today.year}/#{Date.today.year + 1}"
    else
      "#{Date.today.year - 1}/#{Date.today.year}"
    end
  end

  def academic_year_string
    if achived_at.month >= 9
      "#{achived_at.year}/#{achived_at.year + 1}"
    else
      "#{achived_at.year - 1}/#{achived_at.year}"
    end
  end

  def self.to_csv
    # Attributes to get
    attributes = %w{id record_name_id name score round bowstyle achived_at academic_year_string gender}

    c = CSV.generate(headers: true) do |csv|
      # Headers for the CSV
      csv << ['id', 'user id', 'name', 'score', 'round', 'bowstyle', 'achived at', 'academic year', 'gender']

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def self.format_rounds
    h = Hash.new

    rounds.each { |k, v| h[k] = k.scan(/[A-Z][a-z]+|[0-9]+/).join(" ") }

    return h
  end

  private
  def valid_score?
    errors.add(:base, 'Score must be > 0 and < Max Score for the round') unless (score.nil? == false) && (score >= 0) && (score <= max_round_score)
  end

  def max_round_score
    case round
    when 'Portsmouth', 'Vegas', 'Fita18'
      600
    when 'Bray1', 'Worcester'
      300
    when 'York','Hereford', 'Bristol1', 'Bristol2', 'Bristol3', 'Bristol4', 'Bristol5'
      1296
    when 'Fita70', 'Fita60', 'LongMetric', 'LongMetric1', 'LongMetric2', 'LongMetric3', 'LongMetric4', 'LongMetric5', 'ShortMetric', 'ShortMetric1', 'ShortMetric2', 'ShortMetric3', 'ShortMetric4', 'ShortMetric5', 'HalfMetric1', 'HalfMetric2', 'HalfMetric3', 'HalfMetric4', 'HalfMetric5'
      720
    when 'Metric1', 'Metric2', 'Metric3', 'Metric4', 'Metric5'
      1440
    else
      2 ** ([42].pack('i').size * 16 - 2) - 1
    end
  end
end

# r = Record.new(record_name: RecordName.first, round: :portsmouth, bowstyle: :afb, achived_at: Date.new, location: 'hre')
