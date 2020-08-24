class Task < ApplicationRecord
  # model associação
  has_many :items, dependent: :destroy
  # validações
  validates_presence_of :title, :created_by
end
