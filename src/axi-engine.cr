require "raze"
require "yaml"
require "json"

post "/api/create" do |ctx|
  ctx.response.content_type = "application/json"

  raw_body = ctx.request.body.as(IO).gets_to_end
  data = YAML.parse_all(raw_body)

  services = data.map {|item| item["name"].to_s}

  {data: "Created!", services: services}.to_json
end

Raze.run
