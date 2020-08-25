require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  # criar usuário de teste
  let!(:user) { create(:user) }
   # definir cabeçalhos para autorização
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  describe "#authorize_request" do
    context "quando o token de autenticação é passado" do
      before { allow(request).to receive(:headers).and_return(headers) }

      # método privado authorize_request retorna o usuário atual
      it "define o usuário atual" do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context "quando o token de autenticação não é passado" do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it "levanta erro MissingToken" do
        expect { subject.instance_eval { authorize_request } }.
          to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end