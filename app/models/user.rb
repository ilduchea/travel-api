class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_confirmation_of :password
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true
  has_many :reviews


  # def self.authenticate(email, password)
  #   user = User.find_by "email = ?", email
  #   if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  #     user
  #   else
  #     nil
  #   end
  # end
end
