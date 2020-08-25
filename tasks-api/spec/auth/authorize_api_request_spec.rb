require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  # Criar usuário de teste
  let(:user) { create(:user) }
  # Mock `Authorization` cabeçalho
  let(:header) { { 'Authorization' => token_generator(user.id) } }
  # Assunto do pedido inválido
  subject(:invalid_request_obj) { described_class.new({}) }
  # Assunto do pedido válido
  subject(:request_obj) { described_class.new(header) }

  # Test Suite para AuthorizeApiRequest # call
  # Este é o nosso ponto de entrada na classe de serviço
  describe '#call' do
    # retorna o objeto do usuário quando a solicitação é válida
    context 'quando pedido válido' do
      it 'retorna o objeto do usuário' do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    # retorna mensagem de erro quando pedido inválido
    context 'quando pedido inválido' do
      context 'quando falta o token' do
        it 'levanta um erro MissingToken' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'quando token inválido' do
        subject(:invalid_request_obj) do
          # método auxiliar personalizado `token_generator`
          described_class.new('Authorization' => token_generator(5))
        end

        it 'levanta um erro InvalidToken' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'quando o token expira' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'gera erro ExceptionHandler :: ExpiredSignature' do
          expect { request_obj.call }
            .to raise_error(
              ExceptionHandler::InvalidToken,
              /Signature has expired/
            )
        end
      end

      context 'token falso' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'lida com JWT :: DecodeError' do
          expect { invalid_request_obj.call }
            .to raise_error(
              ExceptionHandler::InvalidToken,
              /Not enough or too many segments/
            )
        end
      end
    end
  end
end