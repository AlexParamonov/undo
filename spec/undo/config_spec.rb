require "spec_helper_lite"

describe Undo::Config do
  describe "#filter" do
    it "removes known attributes" do
      subject.class.attribute :known
      expect(subject.filter known: true, unknown: true).to eq unknown: true
    end
  end
end
