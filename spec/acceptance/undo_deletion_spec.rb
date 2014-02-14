require "spec_helper_rails"

describe "Undo deletion" do
  subject { Undo::Model }

  it "reverts user deletion" do
    user = create :user
    undoable_model = subject.new user
    undoable_model.destroy
    restored_user = subject.restore undoable_model.uuid

    expect(restored_user).to eq user
  end
end
