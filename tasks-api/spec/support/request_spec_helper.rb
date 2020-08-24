module RequestSpecHelper
  # Analisar a resposta JSON para ruby hash
  def json
    JSON.parse(response.body)
  end
end