require "spec_helper_lite"
require "undo/serializer/null"

describe Undo::Serializer::Null do
  subject { described_class }
  let(:serializer) { described_class.new }

  it "returns object for any method call" do
    object = { "hello" => "world" }
    result = serializer.to_something object
    expect(result).to eq "hello" => "world"
  end

  it "returns object for any future added method calls" do # to_json for ex
    require "json"
    object = { "hello" => "world" }
    result = serializer.to_json object
    expect(result).to eq "hello" => "world"
  end

  describe "#restore" do
    it "returns passed argument" do
      result = serializer.load_from_something("hello world")
      expect(result).to eq "hello world"
    end
  end
end
