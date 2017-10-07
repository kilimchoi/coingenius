shared_context :worker_examples do
  let(:worker) { described_class.new }

  it { is_expected.to be_kind_of(Sidekiq::Worker) }

  describe ".sidekiq_options" do
    subject { described_class.sidekiq_options.symbolize_keys }

    it { is_expected.to include(sidekiq_options) }
  end
end
