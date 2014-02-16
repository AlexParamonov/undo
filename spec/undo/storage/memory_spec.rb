require "spec_helper_lite"
require 'undo/storage/memory'

describe Undo::Storage::Memory do
  subject { described_class }
  let(:adapter) { subject.new }
  let(:object) { double :object }

  it "stores any object" do
    adapter.put 123, object
    expect(adapter.fetch 123).to eq object
  end
end
