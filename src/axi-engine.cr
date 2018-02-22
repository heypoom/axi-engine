require "raze"
require "yaml"
require "colorize"

post "/api/create" do |ctx|
  ctx.response.content_type = "application/json"
  body = ctx.request.body.as(IO).gets_to_end

  data = YAML.parse_all(body)

  print "YAML: ".colorize(:blue)

  services = data
    .map {|item| {item["name"].to_s => item["kind"].to_s}}
    .reduce {|x, y| x.merge(y)}

  {data: "Created!", services: services}.to_json
end

Raze.run
