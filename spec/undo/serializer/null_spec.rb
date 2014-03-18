require "spec_helper_lite"
require "undo/serializer/null"

describe Undo::Serializer::Null do
  describe "returns passed argument" do
    let(:object) { double :object }

    specify "#serialize" do
      expect(subject.serialize object).to eq object
    end

    specify "#deserialize" do
      expect(subject.deserialize object).to eq object
    end
  end
end
