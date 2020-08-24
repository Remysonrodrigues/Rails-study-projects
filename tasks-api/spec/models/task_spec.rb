require 'rails_helper'

# Conjunto de testes para o modelo Task
RSpec.describe Task, type: :model do
  # Teste de associação
  # garantir que o modelo Task tenha uma relação de 1:m com o modelo Item
  it { should have_many(:items).dependent(:destroy) }
  # Testes de validação
  # certifique-se de que as colunas title e created_by estejam presentes antes de salvar
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
