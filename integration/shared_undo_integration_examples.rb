shared_examples "undo integration" do
  subject { Undo }
  let(:object) { Hash.new hello: :world }

  it "stores and restores object" do
    uuid = subject.store object
    expect(subject.restore uuid).to eq object
  end

  it "deletes stored object" do
    uuid = subject.store object
    subject.delete uuid
    expect { subject.restore uuid }.to raise_error(KeyError)
  end

  it "delete an unexisted key does not raise an error" do
    expect { subject.delete "does not exist" }.not_to raise_error
  end

  describe "special cases" do
    it "stores and restores nil" do
      uuid = subject.store nil
      expect(subject.restore uuid).to eq nil
    end

    it "stores and restores array" do
      uuid = subject.store [1,2,3]
      expect(subject.restore uuid).to eq [1,2,3]
    end
  end
end
