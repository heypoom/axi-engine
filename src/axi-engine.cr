require "kemal"

require "./axi-engine/*"

module Axi::Engine
  get "/" do |env|
    env.response.content_type = "application/json"

    {data: "Hello, Jeam! 🙆‍"}.to_json
  end

  ws "/" do |socket|
    socket.send "Hello from Kemal!"

    socket.on_message do |msg|
      socket.send "Echo back from server #{msg}"
    end
  end

  Kemal.run
end
