describe ApiClient do
  describe '#response' do
    let(:response) { subject.response }
    it { expect(response.size).to eq 10 }
    it { expect(response.first.keys).to all( be_an(Symbol)) }
  end
end
