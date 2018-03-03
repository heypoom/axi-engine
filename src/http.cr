require "http/server"
require "process"

class Cluster
  def self.fork (env : Process::Env)
    env["FORKED"] = "1"

    Process.fork {
      Process.run(PROGRAM_NAME, nil, env, true, false)
    }
  end

  def self.master?
   (ENV["FORKED"]? || "0") == "0"
  end

  def self.worker?
   (ENV["FORKED"]? || "0") == "1"
  end
end

def init_cluster()
  workers = 4

  while workers > 0
    print "Forking Worker #{workers.to_s}\n"
    Cluster.fork({"id" => workers.to_s})

    workers -= 1
  end

  sleep
end

def main()
  server = HTTP::Server.new(8080) do |context|
    context.response.content_type = "text/plain"
    context.response.print "OK"
  end

  puts "Listening on http://127.0.0.1:8080"
  server.listen(true)
end

#if Cluster.master?
  #init_cluster()
#else
main()
#end
