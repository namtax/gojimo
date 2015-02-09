require 'active_support/time'

describe DataStore do
  let(:data_file) { "#{Configuration.data_dir}/#{file_name}" }
  let(:file_name) { %q[8f85320b81f6733298390fb0b05f5728.json] }

  describe '.initialize' do
    context 'fresh request' do
      it 'stores data locally' do
        described_class.new
        expect(File.exists?(data_file)).to be true
      end
    end

    context 'data exists' do
      before do
        described_class.new
        FileUtils.touch data_file, :mtime => Time.now - 2.hours
      end

      it 'does not overwrite old data' do
        described_class.new
        described_class.new
        expect(((Time.now - File.mtime(data_file)) / 3600).to_i).to eq 2
      end

      context 'api changes' do
        let(:api_client) { double( response: response ) }
        let(:response)   { double( :[] => etag, body: {}.to_json, code: "200" ) }
        let(:etag)       { "999" }

        it 'creates new data file' do
          allow(ApiClient).to receive(:new).and_return(api_client)
          described_class.new
          expect(Dir["#{Configuration.data_dir}/*"].count).to be 1
          expect(File.exists?("#{Configuration.data_dir}/999.json")).to be true
        end
      end

      context 'server down' do
        it 'does not overwrite old data' do
          allow(ApiClient).to receive(:response).and_return(nil)
          described_class.new
          expect(((Time.now - File.mtime(data_file)) / 3600).to_i).to eq 2
        end
      end
    end
  end

  describe '#fetch' do
    let(:actual) { subject.fetch }
    it { expect(actual.size).to eq 9 }
    it { expect(actual.first.keys).to all( be_an(Symbol)) }
  end
end
