require "spec_helper_lite"
require 'undo/model'

describe Undo::Model do
  subject { Undo::Model }
  before do
    Undo.config do |config|
      config.mutator_methods = [:change]
    end
  end

  it "restores object" do
    object = double :object, change: true

    undoable_model = subject.new object
    undoable_model.change
    restored_object = subject.restore undoable_model.uuid

    expect(restored_object).to eq object
  end
end
