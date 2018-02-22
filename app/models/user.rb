class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_secure_token :authentication_token

  validates :first_name,  presence: true, length: { maximum: 20 }
  validates :last_name,  presence: true, length: { maximum: 20 }
  validates :address_line_1,  presence: true, length: { maximum: 50 }
  validates_presence_of :dob

  has_many :transfers

  def full_name
    return first_name + " " + last_name
  end

  def age
    age = Date.today.year - dob.year
    age -= 1 if Date.today < dob + age.years
  end
end
