require 'active_support/time'

describe ApiClient do
  describe '.response' do
    let(:response) { {} }
    before { allow(Net::HTTP).to receive(:start).and_return(response) }
    it     { expect(ApiClient.response).to eq response }
  end

  context 'server error' do
    before { allow(Net::HTTP).to receive(:start).and_raise }
    it     { expect(ApiClient.response).to be nil }
  end
end
