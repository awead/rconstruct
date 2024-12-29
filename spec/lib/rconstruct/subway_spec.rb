RSpec.describe Rconstruct::Subway do
  let(:mock_client) { instance_spy(Rcon::Client) }
  let(:origin) { Rconstruct::Coordinate.new(0, 0, 0) }

  subject { mock_client }

  before do
    allow(Rconstruct::Client).to receive(:new).and_return(mock_client)
  end

  describe "::draw" do
    context "with default parameters" do
      before do
        described_class.draw(
          x: 0,
          y: 0,
          z: 0,
          length: 10
        )
      end

      it { is_expected.to have_received(:execute).exactly(122).times }
    end

    context "with alternative parameters" do
      before do
        described_class.draw(
          x: 0,
          y: 0,
          z: 0,
          length: 10,
          direction: :south,
          attitude: :up,
          roof: "glass"
        )
      end

      it { is_expected.to have_received(:execute).exactly(186).times }
    end

    context "going east" do
      before do
        described_class.draw(
          x: 0,
          y: 0,
          z: 0,
          length: 10,
          direction: :east
        )
      end

      it { is_expected.to have_received(:execute).exactly(122).times }
    end

    context "going west" do
      before do
        described_class.draw(
          x: 0,
          y: 0,
          z: 0,
          length: 10,
          direction: :west
        )
      end

      it { is_expected.to have_received(:execute).exactly(122).times }
    end

    context "with bad directions" do
      it "raises an error" do
        expect {
          described_class.draw(
            x: 0,
            y: 0,
            z: 0,
            length: 10,
            direction: :nowhere
          )
        }.to raise_error(ArgumentError, "Bad direction")
      end
    end
  end
end
