require "spec_helper_lite"
require 'undo/storage/memory'

describe Undo::Storage::Memory do
  subject { described_class }
  let(:adapter) { subject.new }
  let(:object) { double :object }

  it "stores any object" do
    adapter.store 123, object
    expect(adapter.fetch 123).to eq object
  end

  it "deletes stored object" do
    adapter.store 123, object
    adapter.delete 123
    expect { adapter.fetch 123 }.to raise_error(KeyError)
  end
end
