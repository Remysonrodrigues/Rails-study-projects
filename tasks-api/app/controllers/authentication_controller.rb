class AuthenticationController < ApplicationController
  # retornar token de autenticação assim que o usuário for autenticado
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

    def auth_params
      params.permit(:email, :password)
    end
    
end
