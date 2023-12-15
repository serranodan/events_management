class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  validates :name, :role, presence: true

  enum role: { professor: 'professor', student: 'student' }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "current_sign_in_at", "current_sign_in_ip", "email", "encrypted_password", "id", "id_value", "last_sign_in_at", "last_sign_in_ip", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "sign_in_count", "updated_at"]
  end
end
