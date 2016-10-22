# set path to application
project_dir = "/var/apps/kev.cool"
current_dir = "#{ project_dir }/current"
shared_dir = "#{ project_dir }/shared"

working_directory current_dir

# Set unicorn options
worker_processes 3
preload_app true
timeout 30

# Set up socket location
listen "#{ shared_dir }/tmp/sockets/unicorn.sock", backlog: 64

# Logging
stderr_path "#{ shared_dir }/log/unicorn.stderr.log"
stdout_path "#{ shared_dir }/log/unicorn.stdout.log"

# Set master PID location
pid "#{ shared_dir }/tmp/pids/unicorn.pid"
