require 'rails_helper'

RSpec.describe AuthenticateUser do
  # criar usuário de teste
  let(:user) { create(:user) }
  # assunto de pedido válido
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  # assunto de pedido inválido
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  # Conjunto de testes para AuthenticateUser # chamada (call)
  describe '#call' do
    # token de retorno quando pedido válido
    context 'quando credenciais válidas' do
      it 'retorna um token de autenticação' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # aumentar o erro de autenticação quando o pedido for inválido
    context 'quando credenciais inválidas' do
      it 'levanta um erro de autenticação' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /Invalid credentials/
          )
      end
    end
  end
end