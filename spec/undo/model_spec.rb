require "spec_helper_lite"
require 'undo/model'

describe Undo::Model do
  subject { Undo::Model }
  let(:object) { double :object, change: true }

  before do
    Undo.config do |config|
      config.mutator_methods = [:change]
    end
  end

  it "restores object" do
    undoable_model = subject.new object
    undoable_model.change
    restored_object = subject.restore undoable_model.uuid

    expect(restored_object).to eq object
  end

  describe "with options" do
    it "restores using provided options" do
      storage = double
      expect(storage).to receive(:put)
      expect(storage).to receive(:fetch) { object }

      undoable_model = subject.new object, storage: storage
      undoable_model.change
      restored_object = subject.restore undoable_model.uuid, storage: storage

      expect(restored_object).to eq object
    end
  end
end
