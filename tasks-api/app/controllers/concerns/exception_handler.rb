module ExceptionHandler
  # fornece o método `included` mais elegante
  extend ActiveSupport::Concern

  # Definir subclasses de erro personalizadas - resgate captura `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do

    # Defina manipuladores personalizados
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    # rescue_from ActiveRecord::RecordInvalid do |e|
      # json_response({ message: e.message }, :unprocessable_entity)
    # end
  end

  private
    # Resposta JSON com mensagem; Código de status 422 - entidade não processável
    def four_twenty_two(e)
      json_response({ message: e.message }, :unprocessable_entity)
    end

    # Resposta JSON com mensagem; Código de status 401 - não autorizado
    def unauthorized_request(e)
      json_response({ message: e.message }, :unauthorized)
    end

end