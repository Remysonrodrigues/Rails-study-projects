class Produto < ApplicationRecord
  validates :preco, presence: true
end
