require "spec_helper_lite"
require 'undo/storage/memory'

describe Undo::Storage::Memory do
  let(:object) { double :object }

  it "stores any object" do
    subject.store 123, object
    expect(subject.fetch 123).to eq object
  end

  it "deletes stored object" do
    subject.store 123, object
    subject.delete 123
    expect { subject.fetch 123 }.to raise_error(KeyError)
  end
end
