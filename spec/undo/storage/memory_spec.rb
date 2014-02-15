require "spec_helper_lite"
require "undo/storage/memory"

describe Undo::Storage::Memory do
  subject { described_class }
  let(:adapter) { subject.new serializer: serializer }
  let(:serializer) { double :serializer }
  let(:object) { double :object }

  it "requires serializer" do
    expect { described_class.new }.to raise_exception(KeyError)
    expect { described_class.new serializer: double }.not_to raise_exception
  end

  describe "serialization" do
    it "serializes using #to_memory_object" do
      expect(serializer).to receive(:to_memory_object).with object
      adapter.put 123, object
    end

    it "deserializes using #from_memory_object" do
      expect(serializer).to receive(:from_memory_object).with object
      allow(serializer).to receive(:to_memory_object) { object }
      adapter.put 123, object
      adapter.fetch 123
    end
  end
end
