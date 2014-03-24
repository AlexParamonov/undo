require "spec_helper_lite"

describe Undo::Wrapper do
  subject do
    described_class.new(
      object,
      store_on: [:change]
    )
  end

  let(:object) { double :object, change: "changed" }
  let(:uuid) { double :uuid }

  describe "when mutation method is called" do
    it "calls the method and returns result" do
      expect(subject.change).to eq "changed"
    end
  end
end
