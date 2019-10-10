require_relative 'boot'

require 'rails'
require 'active_job/railtie'

Bundler.require(*Rails.groups)
require 'delayed_job'
require 'delayed_job_mongoid'

module Dummy
  class Application < Rails::Application
    config.active_job.queue_adapter = :delayed_job
  end
end
