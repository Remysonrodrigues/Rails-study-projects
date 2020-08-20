class Produto < ApplicationRecord

  belongs_to :departamento, optional: true # Identifica que produto pertence a um departamento

  validates :preco, :departamento, presence: true
  validates :nome, length: { minimum: 4 }
end
