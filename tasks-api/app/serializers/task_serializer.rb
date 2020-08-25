class TaskSerializer < ActiveModel::Serializer
  # atributos a serem serializados 
  attributes :id, :title, :created_by, :created_at, :updated_at
  # associação modelo
  has_many :items
end
