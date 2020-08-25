module ControllerSpecHelper
  # gerar tokens do id do usuário
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # gerar tokens expirados do id do usuário
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # retornar cabeçalhos válidos
  def valid_headers
    {
      "Authorization" => token_generator(user.id),
      "Content-Type" => "application/json"
    }
  end

  # retornar cabeçalhos inválidos
  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end
end