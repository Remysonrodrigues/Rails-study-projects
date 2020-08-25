require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Suite de teste de autenticação
  describe 'POST /auth/login' do
    # criar usuário de teste
    let!(:user) { create(:user) }
    # definir cabeçalhos para autorização
    let(:headers) { valid_headers.except('Authorization') }
    # definir credenciais de teste válidas e inválidas
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # definir request.headers para nossos cabeçalhos personalizados
    # before { allow(request).to receive(:headers).and_return(headers) }

    # retorna o token de autenticação quando a solicitação é válida
    context 'Quando o pedido é válido' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'retorna um token de autenticação' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # retorna mensagem de falha quando a solicitação é inválida
    context 'Quando o pedido é inválido' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'retorna uma mensagem de falha' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end
