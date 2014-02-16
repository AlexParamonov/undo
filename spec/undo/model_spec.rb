require "spec_helper_lite"

describe Undo::Model do
  subject { described_class }
  let(:model) { subject.new object }
  let(:object) { double :object }

  describe "#uuid" do
    it "using object#uuid" do
      expect(object).to receive(:uuid) { "123" }
      expect(model.uuid).to eq "123"
    end

    context "object do not respond to #uuid" do
      it "using configured uuid gerenator" do
        model = subject.new object, uuid_generator: proc { "123" }
        expect(model.uuid).to eq "123"
      end

      it "using SecureRandom uuid gerenator by default" do
        expect(SecureRandom).to receive(:uuid) { "123" }
        expect(model.uuid).to eq "123"
      end

      it "passes object to custom uuid gerenator" do
        uuid_generator = double :uuid_generator
        expect(uuid_generator).to receive(:call).with(object)

        model = subject.new object, uuid_generator: uuid_generator
        model.uuid
      end

    end

    describe "stores object data" do
      let(:object) { double :object, change: true }
      let(:storage) { double :storage }
      let(:serializer) { double :serializer }

      specify "when called mutator method" do
        expect(storage).to receive(:put)

        model = subject.new object,
                            storage: storage,
                            mutator_methods: [:change]
        model.change
      end

      it "serializes data before storing" do
        expect(serializer).to receive(:serialize).with(object).ordered
        expect(storage).to receive(:put).ordered

        model = subject.new object,
                            storage: storage,
                            serializer: serializer,
                            mutator_methods: [:change]
        model.change
      end
    end
  end
end
