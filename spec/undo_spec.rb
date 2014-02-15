require "spec_helper_lite"

describe Undo do
  subject { Undo }

  describe "#wrap" do
    let(:object) { double :object, change: true }

    before do
      subject.config do |config|
        config.mutator_methods = [:change]
      end
    end

    it "is a decorator" do
      object = [:a, :b]
      decorator = subject.wrap object
      expect(object).to receive(:some_method)

      decorator.some_method
      expect(object.class).to eq Array
    end

    it "restores object" do
      undoable_model = subject.wrap object
      undoable_model.change
      restored_object = subject.restore undoable_model.uuid

      expect(restored_object).to eq object
    end

    describe "with options" do
      it "restores using provided options" do
        storage = double
        expect(storage).to receive(:put)
        expect(storage).to receive(:fetch) { object }

        undoable_model = subject.wrap object, storage: storage
        undoable_model.change
        restored_object = subject.restore undoable_model.uuid, storage: storage

        expect(restored_object).to eq object
      end
    end
  end
end
