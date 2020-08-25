class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Ponto de entrada do serviço - retornar objeto de usuário válido
  def call
    {
      user: user
    }
  end

  private

  attr_reader :headers

  def user
    # verifique se o usuário está no banco de dados
    # memoize objeto de usuário
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    # lidar com usuário não encontrado
  rescue ActiveRecord::RecordNotFound => e
    # aumentar erro personalizado
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  # decodificar token de autenticação
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # verificar o token no cabeçalho `Authorization`
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
      raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end