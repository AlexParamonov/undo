require "spec_helper_lite"

describe Undo::Wrapper do
  subject do
    described_class.new(
      uuid,
      object,
      mutator_methods: :change
    )
  end

  let(:object) { double :object, change: "changed" }
  let(:uuid) { double :uuid }

  describe "when mutator method called" do
    it "stores the object under given uuid" do
      expect(Undo).to receive(:store).with(object, uuid: uuid)
      subject.change
    end

    it "calls the method and returns result" do
      expect(subject.change).to eq "changed"
    end
  end

  it "returns provided uuid" do
    expect(subject.uuid).to eq uuid
  end
end
