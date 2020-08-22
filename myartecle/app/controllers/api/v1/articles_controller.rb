module Api
  module V1
    class ArticlesController < ApplicationController
      # Listar todos os artigos
      def index
        articles = Article.order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Artigos carregados', data: articles }, status: :ok
      end
      # Listar artigo passando ID
      def show
        article = Article.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Loaded article', data: article }, status: :ok
      end
      
    end
  end
end