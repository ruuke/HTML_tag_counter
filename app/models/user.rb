class User < ApplicationRecord
  
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable
  
  has_many :documents

  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i }

  def full_name
    "#{first_name} #{last_name}"
  end
  
end
