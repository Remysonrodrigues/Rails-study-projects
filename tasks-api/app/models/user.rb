class User < ApplicationRecord
  # criptografar senha
  has_secure_password

  # Associações de modelo
  has_many :tasks, foreign_key: :created_by
  # Validações
  validates_presence_of :name, :email, :password_digest
end
