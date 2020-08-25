require 'rails_helper'

RSpec.describe "Tasks API", type: :request do
  # add tasks owner
  # inicializar dados de teste
  let(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 10, created_by: user.id) }
  let(:task_id) { tasks.first.id }
  # autorizar pedido
  let(:headers) { valid_headers }

  # Conjunto de testes para GET / tasks
  describe 'GET /tasks' do
    # faça a solicitação HTTP get antes de cada exemplo
    # solicitação de atualização com cabeçalhos
    before { get '/tasks', params: {}, headers: headers }

    it 'returns tasks' do
      # Observe que `json` é um auxiliar personalizado para analisar respostas JSON
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Conjunto de testes para GET /tasks/:id
  describe 'GET /tasks/:id' do
    before { get "/tasks/#{task_id}", params: {}, headers: headers }

    context 'quando o registro existe' do
      it 'returns a tasks' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(task_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'quando o registro não existe' do
      let(:task_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'retorna uma mensagem não encontrada' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Conjunto de testes para POST /tasks
  describe 'POST /tasks' do
    # validar atributos
    let(:valid_attributes) do
      # send json payload
      { title: 'Learn Elm', created_by: user.id.to_s }.to_json
    end

    context 'quando o pedido é válido' do
      before { post '/tasks', params: valid_attributes, headers: headers }

      it 'cria uma task' do
        expect(json['title']).to eq('Ruby on rails')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'quando o pedido é inválido' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/tasks', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'retorna uma mensagem de falha de validação' do
        expect(json['message'])
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Conjunto de testes para PUT /tasks/:id
  describe 'PUT /tasks/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'quando o registro existe' do
      before { put "/tasks/#{task_id}", params: valid_attributes, headers: headers }

      it 'atualiza o registro' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Conjunto de testes para DELETE /tasks/:id
  describe 'DELETE /todos/:id' do
    before { delete "/tasks/#{task_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
