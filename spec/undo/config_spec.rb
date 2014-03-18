require "spec_helper_lite"

describe Undo::Config do
  describe "#filter" do
    it "removes all recognized attributes from input hash" do
      allow(subject).to receive(:recognized_attributes) { [:known] }
      expect(subject.filter known: true, unknown: true).to eq unknown: true
    end
  end

  describe "#recognized_attributes" do
    it "includes all attribute names" do
      expect(subject.recognized_attributes).to match_array(subject.attributes.keys)
    end
  end
end
