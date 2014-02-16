require "spec_helper_lite"
require "undo/serializer/null"

describe Undo::Serializer::Null do
  subject { described_class }
  let(:serializer) { described_class.new }

  describe "returns passed argument" do
    let(:object) { double :object }

    specify "#serialize" do
      expect(serializer.serialize object).to eq object
    end

    specify "#deserialize" do
      expect(serializer.deserialize object).to eq object
    end
  end
end
