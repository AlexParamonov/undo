require "spec_helper_lite"
require "undo/container/json"

describe Undo::Container::Json do
  let(:container) { described_class.new }

  it "packs to json" do
    json = container.pack "hello" => "world"
    expect(json).to eq '{"hello":"world"}'
  end

  it "unpaks from json" do
    hash = container.unpack '{"hello":"world"}'
    expect(hash).to eq "hello" => "world"
  end
end
