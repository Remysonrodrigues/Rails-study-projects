require 'rails_helper'

RSpec.describe "Items API", type: :request do
  # Inicialize os dados de teste
  let!(:task) { create(:task) }
  let!(:items) { create_list(:item, 20, task_id: task.id) }
  let(:task_id) { task.id }
  let(:id) { items.first.id }

  # Conjunto de testes para GET /tasks/:task_id/items
  describe 'GET /tasks/:task_id/items' do
    before { get "/tasks/#{task_id}/items" }

    context 'quando a tarefa existe' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'retorna todos os itens de tarefa' do
        expect(json.size).to eq(20)
      end
    end

    context 'quando a tarefa não existe' do
      let(:task_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'retorna uma mensagem não encontrada' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Conjunto de teste para GET /tasks/:task_id/items/:id
  describe 'GET /tasks/:task_id/items/:id' do
    before { get "/tasks/#{task_id}/items/#{id}" }

    context 'quando a tarefa existe' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns o item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'quando a tarefa não existe' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'retorna uma mensagem não encontrada' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Conjunto de teste para PUT /tasks/:task_id/items
  describe 'POST /tasks/:task_id/items' do
    let(:valid_attributes) { { name: 'Visitar Narnia', done: false } }

    context 'quando os atributos do pedido são válidos' do
      before { post "/tasks/#{task_id}/items", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'quando um pedido inválido' do
      before { post "/tasks/#{task_id}/items", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'retorna uma mensagem de falha' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Conjunto de teste para PUT /tasks/:task_id/items/:id
  describe 'PUT /tasks/:task_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/tasks/#{task_id}/items/#{id}", params: valid_attributes }

    context 'quando o item existe' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'atualiza o item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context 'quando o item não existe' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'retorna uma mensagem não encontrada' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Conjunto de teste para DELETE /tasks/:id
  describe 'DELETE /tasks/:id' do
    before { delete "/tasks/#{task_id}/items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
 
end
