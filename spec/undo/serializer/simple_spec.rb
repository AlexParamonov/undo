require "spec_helper_lite"
require "undo/serializer/simple"

describe Undo::Serializer::Simple do
  subject { described_class }
  let(:serializer) { described_class.new }

  it "serializes to json" do
    object = { "hello" => "world" }
    result = serializer.to_json object
    expect(result).to eq '{"hello":"world"}'
  end

  it "deserializes from json" do
    serialized_object = '{"hello":"world"}'
    result = serializer.from_json serialized_object
    expect(result).to eq "hello" => "world"
  end
end
