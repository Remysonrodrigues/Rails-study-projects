class ProdutosController < ApplicationController

  def index
    @produtos = Produto.order(nome: :asc).limit 6
    @produto_com_desconto = Produto.order(:preco).limit 1
  end

  def new
    @produto = Produto.new
    @departamentos = Departamento.all
  end
  
  def create
    valores = params.require(:produto).permit(:nome, :descricao, :preco, :quantidade)
    @produto = Produto.new valores
    if @produto.save
      flash[:notice] = "Produto salvo com sucesso!"
      redirect_to root_url # Retorna para pagina principal
    else
      render :new # Renderiza a pagina atual
    end
  end
  
  def destroy
    id = params[:id]
    Produto.destroy id
    redirect_to root_url
  end
  
  def busca
    @nome = params[:nome]
    @produtos = Produto.where "nome like ?", "%#{@nome}%"
  end
  
end
