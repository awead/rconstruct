RSpec.describe Rconstruct::Cylinder do
  let(:mock_client) { instance_spy(Rcon::Client) }

  subject { mock_client }

  before do
    allow(Rconstruct::Client).to receive(:new).and_return(mock_client)
  end

  describe "::draw" do
    context "when the cylinder is hollow" do
      before { described_class.draw(x: 1, y: 1, z: 1, radius: 1, height: 10, block_type: "stone") }

      it { is_expected.to have_received(:execute).exactly(40).times }
    end

    context "when the cylinder is solid" do
      before { described_class.draw(x: 1, y: 1, z: 1, radius: 1, height: 10, block_type: "stone", hollow: false) }

      it { is_expected.to have_received(:execute).exactly(50).times }
    end
  end
end
