class JsonWebToken
  # segredo para codificar e decodificar token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    # definir expiração para 24 horas a partir do momento da criação
    payload[:exp] = exp.to_i
    # assinar token com o segredo do aplicativo
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # obter carga útil; primeiro índice em Array decodificado
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
    # resgate de todos os erros de decodificação
  rescue JWT::DecodeError => e
    # aumentar o erro personalizado a ser tratado pelo manipulador personalizado
    raise ExceptionHandler::InvalidToken, e.message
  end
end