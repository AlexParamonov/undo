require "spec_helper_lite"

describe Undo do
  let(:object) { double :object, change: true }
  subject { described_class }

  it "stores and restores object" do
    uuid = subject.store object
    expect(subject.restore uuid).to eq object
  end

  it "stores and restores object using provided uuid" do
    uuid = "uniq_identifier"
    subject.store object, uuid: uuid

    expect(subject.restore uuid).to eq object
  end

  describe "serializing" do
    let(:storage) { double :storage }
    let(:serializer) { double :serializer }

    it "serializes data before storing" do
      expect(serializer).to receive(:serialize).with(object).ordered
      expect(storage).to receive(:put).ordered

      subject.store object,
        storage: storage,
        serializer: serializer
    end

    it "deserializes data before restoring" do
      uuid = subject.store object

      expect(storage).to receive(:fetch).and_return(foo: :bar).ordered
      expect(serializer).to receive(:deserialize).with(foo: :bar).ordered

      subject.restore uuid,
        storage: storage,
        serializer: serializer
    end
  end

  describe "#wrap" do
    before do
      subject.configure do |config|
        config.mutator_methods = [:change]
      end
    end

    it "is a decorator" do
      object = %w[hello world]

      decorator = subject.wrap object
      expect(object).to receive(:some_method)
      decorator.some_method

      expect(decorator.class).to eq Array
      expect(decorator).to be_a Array
    end

    describe "restores" do
      specify "using provided uuid" do
        uuid = "uniq_identifier"
        model = subject.wrap object, uuid: uuid
        model.change

        expect(subject.restore uuid).to eq object
      end

      specify "using gerenated uuid" do
        model = subject.wrap object
        model.change

        expect(subject.restore model.uuid).to eq object
      end
    end
  end
end
