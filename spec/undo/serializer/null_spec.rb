require "spec_helper_lite"
require "undo/serializer/null"

describe Undo::Serializer::Null do
  let(:object) { double :object }

  describe "returns passed argument" do
    specify "#serialize" do
      expect(subject.serialize object).to eq object
    end

    specify "#deserialize" do
      expect(subject.deserialize object).to eq object
    end
  end

  it "accepts options" do
    options = { foo: :bar }
    expect do
      subject.serialize object, options
      subject.deserialize object, options
    end.not_to raise_error
  end
end
