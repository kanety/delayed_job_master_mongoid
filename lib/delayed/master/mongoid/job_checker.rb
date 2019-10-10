require_relative 'job_counter'

module Delayed
  class Master
    class JobChecker
      def initialize(master)
        @master = master
        @config = master.config
      end

      def check
        workers = []

        find_jobs do |setting|
          workers << Worker.new(index: @master.workers.size + workers.size, setting: setting)
        end

        workers
      end

      private

      def find_jobs
        counter = JobCounter.new

        @config.worker_settings.each do |setting|
          count = @master.workers.count { |worker| worker.setting.queues == setting.queues }
          slot = setting.count - count
          if slot > 0 && (job_count = counter.count(setting)) > 0
            [slot, job_count].min.times do
              yield setting
            end
          end
        end
      end
    end
  end
end
