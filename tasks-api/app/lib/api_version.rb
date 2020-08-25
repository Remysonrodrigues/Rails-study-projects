class ApiVersion
  attr_reader :version, :default

  def initialize(version, default = false)
    @version = version
    @default = default
  end

  # verifique se a versão é especificada ou padrão
  def matches?(request)
    check_headers(request.headers) || default
  end

  private

    def check_headers(headers)
      # verificar a versão nos cabeçalhos de aceitação; esperar tipo de mídia personalizado `tasks`
      accept = headers[:accept]
      accept && accept.include?("application/vnd.todos.#{version}+json")
    end

end