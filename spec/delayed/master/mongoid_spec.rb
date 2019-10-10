describe Delayed::Master::Mongoid do
  describe Delayed::Master do
    let(:tester) do
      MasterTester.new(Rails.root.join("config/delayed_job_master.rb").to_s)
    end
  
    before do
      Delayed::Job.delete_all
    end
  
    it 'runs workers' do
      tester.start do |master|
        tester.enqueue_timer_job(:primary, queue: 'queue1')
        tester.enqueue_timer_job(:primary, queue: 'queue2')
        expect(Delayed::Job.count).to eq(2)
        tester.wait_job_performing(:primary)
        expect(master.workers.size).to eq(2)
        tester.wait_job_performed(:primary)
      end

      expect(Delayed::Job.count).to eq(0)
    end
  end
end
