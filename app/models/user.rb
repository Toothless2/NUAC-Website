class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_one :record_name, dependent: :nullify
  after_save :update_record
  
  private
  def update_record
    r = RecordName.find_or_create_by(user: self)
    r.name = self.name
    r.save
  end
end
