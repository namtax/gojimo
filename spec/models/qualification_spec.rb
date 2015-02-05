describe Qualification do
  subject     { Qualification.new(input) }
  let(:input) { JSON.parse(raw, symbolize_names: true)}
  let(:raw)   { File.read(File.expand_path('spec/support/fixtures/qualifications.json')) }

  it { expect(subject.id).to eq "d45945e4-b724-48ab-9f99-21e61f1648ad"  }
  it { expect(subject.name).to eq "11+ Common Entrance" }
  it { expect(subject.subjects.size).to eq 3 }
  it { expect(subject.subjects).to all (be_an(Subject)) }
end
