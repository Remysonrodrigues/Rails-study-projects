require 'rails_helper'

# Conjunto de testes para o modelo de item
RSpec.describe Item, type: :model do
  # Teste de associação
  # garantir que um registro de item pertença a um único registro de tarefas
  it { should belong_to(:task) }
  # Teste de validação
  # certifique-se de que o nome da coluna esteja presente antes de salvar
  it { should validate_presence_of(:name) }
end
