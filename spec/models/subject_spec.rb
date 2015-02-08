describe Subject do
  subject     { Subject.new(input) }
  let(:input) { JSON.parse(raw, symbolize_names: true)}
  let(:raw)   { File.read(File.expand_path('spec/support/fixtures/subject.json')) }

  it { expect(subject.id).to eq "ef319206-aa64-41f5-ac67-17a4fb8d10f6" }
  it { expect(subject.title).to eq "English" }
  it { expect(subject.link).to eq "/api/v4/subjects/ef319206-aa64-41f5-ac67-17a4fb8d10f6" }
  it { expect(subject.colour).to eq "#ECF7E2" }
end
