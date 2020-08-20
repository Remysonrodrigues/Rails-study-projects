class Produto < ApplicationRecord

  belongs_to :departamento # Identifica que produto pertence a um departamento

  validates :preco, presence: true
  validates :nome, length: { minimum: 4 }
end
