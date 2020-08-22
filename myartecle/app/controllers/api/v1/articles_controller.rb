module Api
  module V1
    class ArticlesController < ApplicationController
      # Listar todos os artigos
      def index
        articles = Article.order('creted_at DESC')
        render json: { status: 'SUCCESS', message: 'Artigos carregados', data: articles }, status: :ok
      end
      
    end
  end
end