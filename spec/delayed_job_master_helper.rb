class BaseTester
  def enqueue_timer_job(database = :primary, options = {})
    options[:priority] ||= 1
    TimerJob.set(options).perform_later(3)
  end

  def wait_job_performing(database = :primary)
    wait_job_performing_for(database, 6)
  end

  def wait_job_performed(database = :primary)
    wait_job_performed_for(database, 6)
  end

  private

  def delayed_job_klass(database)
    yield Delayed::Job
  end

  def wait_job_performing_for(database, limit)
    wait_while(limit) do
      puts "wait job performing..."
      delayed_job_klass(database) do |klass|
        klass.where(locked_at: nil).count > 0
      end
    end
  end

  def wait_job_performed_for(database, limit)
    wait_while(limit) do
      puts "wait job performed..."
      delayed_job_klass(database) do |klass|
        klass.where(:locked_at.ne => nil).count > 0
      end
    end
  end

  def wait_while(limit)
    wait = 0
    while yield && (wait += 1) < limit
      Thread.pass
      sleep 1
      Thread.pass
    end
  end
end

class MasterTester < BaseTester
  def initialize(config_file)
    @master = Delayed::Master.new(['-c', config_file])
  end

  def start
    thread = Thread.new do
      @master.run
    end

    sleep 0.5 until @master.prepared?

    yield @master

    @master.stop
    thread.join
  end
end
