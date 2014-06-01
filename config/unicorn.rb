# # See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# # documentation.
# # See also http://unicorn.bogomips.org/examples/unicorn.conf.rb for
# # a more verbose configuration using more features.
#

# Our own variable where we deploy this app to
deploy_folder = File.expand_path(File.join(File.dirname(__FILE__), "../.."))
root_folder = "#{deploy_folder}/current"
working_directory "#{root_folder}" # available in 0.94.0+

# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.

worker_processes (ENV['UNICORN_WORKERS'] ? ENV['UNICORN_WORKERS'].to_i : 1)
preload_app true
timeout 60

pid "#{root_folder}/tmp/pids/unicorn.pid"

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
# listen "/var/www/app/abakus-portal/current/tmp/sockets/unicorn.sock", :backlog => 64
listen "/tmp/indigenous-literacy-foundation-unicorn.sock", :backlog => 64
listen 3010 # by default Unicorn listens on port 8080

stderr_path "#{root_folder}/log/unicorn.stderr.log"
stdout_path "#{root_folder}/log/unicorn.stdout.log"

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

# we don't use ActiveRecord yet but inevitably will so have left for now
before_fork do |server, worker|
# This option works in together with preload_app true setting
# What is does is prevent the master process from holding
# the database connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
# Here we are establishing the connection after forking worker
# processes
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

# Load the abakus portal environment variables
if File.exists?('/etc/default/ilf')
  env_list = File.new('/etc/default/ilf').each_line.collect do |line|
    line.split("=", 2).map { |val| val.strip.gsub(/^"(.*)"$/, '\1') }
  end
  env_vars = Hash[*env_list.flatten]
  ENV.update(env_vars)
end

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{root_folder}/Gemfile"
end

before_fork do |server, worker|
  # Send a quit to old workers
  old_pid = root_folder + '/tmp/pids/indigenous-literacy-foundation-unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  # reset sequence number between processes - see https://github.com/assaf/uuid/
  UUID.generator.next_sequence
end
