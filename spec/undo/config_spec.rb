require "spec_helper_lite"

describe Undo::Config do
  describe "#filter" do
    it "removes public attributes" do
      allow(subject).to receive(:public_attributes) { [:known] }
      expect(subject.filter known: true, unknown: true).to eq unknown: true
    end
  end

  describe "#public_attributes" do
    it "includes all attributes" do
      expect(subject.public_attributes).to match_array(subject.attributes.keys)
    end
  end
end
