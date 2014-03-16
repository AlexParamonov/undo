require "spec_helper_lite"

describe Undo::Wrapper do
  subject { described_class }
  let(:model) { subject.new object, uuid: uuid, mutator_methods: mutator_methods }
  let(:mutator_methods) { [:change] }
  let(:object) { double :object, change: true }
  let(:uuid) { double :uuid }

  describe "storage" do
    it "stores object when mutator method is called" do
      expect(model).to receive(:store)
      model.change
    end
  end

  describe "#uuid" do
    it "uses provided uuid" do
      expect(model.uuid).to eq uuid
    end

    describe "when object respond_to uuid" do
      it "uses object#uuid instead" do
        expect(object).to receive(:uuid) { "123" }
        expect(model.uuid).to eq "123"
        expect(Undo).to receive(:store).with(object,  hash_including(uuid: "123"))
        model.change
      end
    end
  end
end
