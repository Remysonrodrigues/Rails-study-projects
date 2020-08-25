class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # chamado antes de cada ação nos controladores
  before_action :authorize_request
  attr_reader :current_user

  private

    # Verifique se há token de solicitação válido e o usuário de retorno
    def authorize_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end

end
