require 'active_support/time'

describe ApiClient do
  describe '.initialize' do
    context 'fresh request' do
      it 'stores data locally' do
        ApiClient.new
        expect(File.exists?(data_file)).to be true
      end
    end

    context 'data exists' do
      it 'contacts api once' do
        expect(Net::HTTP).to receive(:get).once.and_return({}.to_json)
        ApiClient.new
        ApiClient.new
      end
    end

    context 'expired data' do
      before do
        allow(Net::HTTP).to receive(:get).and_return({}.to_json)
        ApiClient.new
        FileUtils.touch data_file, :mtime => Time.now - 2.hours
      end

      it 'contacts api' do
        expect(Net::HTTP).to receive(:get).once.and_return({}.to_json)
        ApiClient.new
        ApiClient.new
      end

      context 'server down' do
        it 'leaves expired data' do
          allow(Net::HTTP).to receive(:get).and_raise
          ApiClient.new
          expect(((Time.now - File.mtime(data_file)) / 3600).to_i).to eq 2
        end
      end
    end
  end

  describe '#response' do
    let(:response) { subject.response }
    it { expect(response.size).to eq 10 }
    it { expect(response.first.keys).to all( be_an(Symbol)) }

    context 'data on disk missing' do
      before { allow(Net::HTTP).to receive(:get).and_raise }
      it     { expect(response).to eq({}) }
    end
  end

  def data_file
    File.expand_path('data/response.json')
  end
end
