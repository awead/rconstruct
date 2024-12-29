RSpec.describe Rconstruct::Hemisphere do
  let(:mock_client) { instance_spy(Rcon::Client) }

  subject { mock_client }

  before do
    allow(Rconstruct::Client).to receive(:new).and_return(mock_client)
  end

  describe "::draw" do
    context "when the hemisphere is hollow" do
      before { described_class.draw(x: 1, y: 1, z: 1, radius: 1, block_type: "stone") }

      it { is_expected.to have_received(:execute).exactly(5).times }
    end

    context "when the hemisphere is solid" do
      before { described_class.draw(x: 1, y: 1, z: 1, radius: 1, block_type: "stone", hollow: false) }

      it { is_expected.to have_received(:execute).exactly(6).times }
    end
  end
end
