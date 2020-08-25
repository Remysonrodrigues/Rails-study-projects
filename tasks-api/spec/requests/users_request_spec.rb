require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  # Conjunto de testes de inscrição de usuário
  describe 'POST /signup' do
    context 'quando pedido válido' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'cria um novo usuário' do
        expect(response).to have_http_status(201)
      end

      it 'retorna mensagem de sucesso' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'retorna um token de autenticação' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'quando pedido inválido' do
      before { post '/signup', params: {}, headers: headers }

      it 'não cria um novo usuário' do
        expect(response).to have_http_status(422)
      end

      it 'retorna mensagem de falha' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end
end
