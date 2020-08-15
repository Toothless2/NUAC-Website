class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: /\A[A-Za-z0-9._%+-]+@(newcastle|ncl)\.ac\.uk\z/, message: 'Must be a NCL email address ending with @newcastle.ac.uk or @ncl.ac.uk'}, on: :create, if: :confirmation_required?

  has_one :record_name, dependent: :nullify
  after_save :update_record

  has_many :records, through: :record_name
  
  private
  def after_confirmation # Run after user confimation
    r = RecordName.new(user: self)
    r.name = self.name
    r.save
  end

  def update_record
    if !self.confirmed? || RecordName.find_by(user: self).nil? # Must be a confirmed user to have a record
      return
    end
    r = RecordName.find_by(user: self)
    r.name = self.name
    r.save
  end

  protected
  def confirmation_required?
    if Rails.env == 'production' # make my life easier
      true
    else
      false
    end
  end
end
