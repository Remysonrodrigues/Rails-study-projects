require 'rails_helper'

# Conjunto de testes para o modelo de usuário
RSpec.describe User, type: :model do
  # Teste de associação
  # garantir que o modelo de usuário tenha uma relação de 1:m com o modelo Task
  it { should have_many(:tasks) }
  # Testes de validação
  # certifique-se de que nome, e-mail e senha_digest estejam presentes antes de salvar
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
