ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

God.watch do |w|
  w.name = "dropfaye"
  w.dir = ROOT
  w.interval = 30.seconds
  w.start = "bundle exec rackup config.ru -s thin -p 5000 -E production"

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
end