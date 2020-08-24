class Item < ApplicationRecord
  # model associação
  belongs_to :task
  # validações
  validates_presence_of :name
end
