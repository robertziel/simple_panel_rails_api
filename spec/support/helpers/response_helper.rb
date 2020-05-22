module ResponseHelper
  def response_body_to_json
    JSON.parse(response.body, symbolize_names: true)
  end
end
