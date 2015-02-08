require 'active_support/time'

describe DataStore do
  let(:response) { {}.to_json }

  describe '.initialize' do
    context 'fresh request' do
      it 'stores data locally' do
        described_class.new
        expect(File.exists?(data_file)).to be true
      end
    end

    context 'data exists' do
      let(:response) { double( body: {}.to_json ) }
      it 'contacts api once' do
        expect(Net::HTTP).to receive(:start).once.and_return(response)
        described_class.new
        described_class.new
      end
    end

    context 'expired data' do
      before do
        allow(Net::HTTP).to receive(:get).and_return(response)
        described_class.new
        FileUtils.touch data_file, :mtime => Time.now - 2.hours
      end

      it 'contacts api' do
        expect(Net::HTTP).to receive(:start).once.and_return(response)
        described_class.new
        described_class.new
      end

      context 'server down' do
        it 'leaves expired data' do
          allow(Net::HTTP).to receive(:start).and_raise
          described_class.new
          expect(((Time.now - File.mtime(data_file)) / 3600).to_i).to eq 2
        end
      end
    end
  end

  describe '#all' do
    let(:actual) { subject.all }
    it { expect(actual.size).to eq 9 }
    it { expect(actual.first.keys).to all( be_an(Symbol)) }
  end

  def data_file
    File.expand_path('data/response.json')
  end
end
