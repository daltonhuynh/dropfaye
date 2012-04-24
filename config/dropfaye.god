# Start with "god -c thin.god"
ROOT = File.dirname(File.dirname(__FILE__))

God.watch do |w|
  w.name = "dropfaye"
  w.dir = ROOT
  w.interval = 30.seconds
  w.start = "foreman start"
  w.log = "#{ROOT}/dropfaye.log"

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = options[:memory_limit]
      c.times = [3, 5] # 3 out of 5 intervals
    end

    restart.condition(:cpu_usage) do |c|
      c.above = options[:cpu_limit]
      c.times = 5
    end
  end

end