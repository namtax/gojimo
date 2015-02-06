describe Qualification do
  subject     { Qualification.new(input) }
  let(:input) { JSON.parse(raw, symbolize_names: true)}
  let(:raw)   { File.read(File.expand_path('spec/support/fixtures/qualifications.json')) }

  before	  { allow_any_instance_of(ApiClient).to receive(:response).and_return(res) }
  let(:res)   { [ { id: 11, name: 'GCSE'} ] }

  describe '.all' do
    let(:actual)		 { Qualification.all.first }
    it 'returns qualification collection' do
      expect(actual).to be_an(Qualification)
      expect(actual.id).to eq 11
      expect(actual.name).to eq 'GCSE'
    end
  end

  describe '.find' do
    let(:actual)		 { Qualification.find('GCSE') }
    it 'returns correct qualification' do
      expect(actual.id).to eq 11
      expect(actual.name).to eq 'GCSE'
    end

    context 'invalid' do
      let(:actual) { Qualification.find('INVALID') }
      it { expect(actual).to be nil }
    end
  end

  it { expect(subject.id).to eq "d45945e4-b724-48ab-9f99-21e61f1648ad"  }
  it { expect(subject.name).to eq "11+ Common Entrance" }
  it { expect(subject.subjects.size).to eq 3 }
  it { expect(subject.subjects).to all (be_an(Subject)) }

  after { Qualification.instance_variable_set(:@all, nil) }
end
