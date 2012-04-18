# Start with "god -c dropfaye.god"

God.watch do |w|
  w.name = "dropfaye"
  w.dir = "/home/dotcloud/current"
  w.interval = 30.seconds # default      
  w.start = "bundle exec rackup config.ru -s thin -p 8080 -E production"
  w.log = "/home/dotcloud/log/dropfaye.log"

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
end
