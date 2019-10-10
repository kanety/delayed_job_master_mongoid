# simplecov
require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'delayed_job_master'
require 'delayed_job_master_mongoid'

require_relative 'delayed_job_master_helper'
