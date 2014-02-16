require "spec_helper_lite"

describe Undo do
  let(:object) { double :object, change: true }
  subject { described_class }

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
  end

  describe "restores object by uuid" do
    it "restores object" do
      model = subject.wrap object
      model.change
      restored_object = subject.restore model.uuid

      expect(restored_object).to eq object
    end

    it "restores using provided options" do
      serializer = double :serializer
      expect(serializer).to receive(:deserialize) { object }

      model = subject.wrap object
      model.change
      restored_object = subject.restore model.uuid, serializer: serializer

      expect(restored_object).to eq object
    end
  end
end
