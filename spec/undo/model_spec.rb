require "spec_helper_lite"

describe Undo::Model do
  subject { described_class }
  let(:model) { subject.new object }
  let(:object) { double :object }

  describe "#uuid" do
    it "using object#uuid" do
      expect(object).to receive(:uuid) { "123" }
      expect(model.uuid).to eq "123"
    end

    context "object do not respond to #uuid" do
      it "using configured uuid gerenator" do
        model = subject.new object, uuid_generator: proc { "123" }
        expect(model.uuid).to eq "123"
      end

      it "using SecureRandom uuid gerenator by default" do
        expect(SecureRandom).to receive(:uuid) { "123" }
        expect(model.uuid).to eq "123"
      end
    end

  end
end
