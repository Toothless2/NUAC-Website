class Record < ApplicationRecord
  belongs_to :record_name

  validates :score, :round, :bowstyle, :achived_at, :location, presence: true
  enum bowstyle: { recurve: 0, compound: 1, barebow: 2, longbow: 3, afb: 4 }
  enum round: { portsmouth: 0, bray1: 1, worcester: 2, vegas: 3, fita18: 4, york: 5, hereford: 13, bristol1: 6, bristol2: 7, bristol3: 8, bristol4: 9, bristol5: 10, fita70: 11, other: 12 }

  def valid?
    super && (score >= 0) && (score <= max_round_score)
  end

  private
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
