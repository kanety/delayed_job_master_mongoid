app_root = defined?(Rails) ? Rails.root : Dir.pwd

# working directory
working_directory app_root

# monitor wait time in second
monitor_wait 1

# path to pid file
pid_file "#{app_root}/tmp/pids/delayed_job_master.pid"

# path to log file
log_file "#{app_root}/log/delayed_job_master.log"

# log level
log_level :debug

# worker
add_worker do |worker|
  worker.queues %w(queue1)
  worker.count 1
end

add_worker do |worker|
  worker.queues %w(queue2)
  worker.count 1
end

before_fork do |master, worker|
  Delayed::Worker.before_fork if defined?(Delayed::Worker)
end

after_fork do |master, worker|
  Delayed::Worker.after_fork if defined?(Delayed::Worker)
end

before_monitor do |master|
end

after_monitor do |master|
end
