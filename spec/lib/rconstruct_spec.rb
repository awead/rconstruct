# frozen_string_literal: true

RSpec.describe Rconstruct do
  it "has a version number" do
    expect(Rconstruct::VERSION).not_to be nil
  end

  describe Rconstruct::Coordinate do
    subject { described_class.new(1, -10, 1) }

    its(:x) { is_expected.to eq(1) }
    its(:y) { is_expected.to eq(-10) }
    its(:z) { is_expected.to eq(1) }
  end
end
