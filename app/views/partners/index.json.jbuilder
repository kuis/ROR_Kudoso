json.array!(@partners) do |partner|
  json.extract! partner, :id, :name, :description, :api_key
  json.url partner_url(partner, format: :json)
end
