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

  it "accepts options" do
    options = { foo: :bar }
    expect do
      subject.store 123, object, options
      subject.fetch 123, options
      subject.delete 123, options
    end.not_to raise_error
  end
end
