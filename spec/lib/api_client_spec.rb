require 'active_support/time'

describe ApiClient do
  describe '.response' do
    it { expect(subject.response.code).to eq "200"}

    context 'data exists' do
      let(:data_dir)  { Configuration.data_dir }
      let(:data_file) { "8f85320b81f6733298390fb0b05f5728.json" }
      before do
        File.open("#{data_dir}/#{data_file}", 'w+') do |f|
          f.write({})
        end
      end
      it { expect(subject.response.code).to eq "304" }
    end
  end

  context 'server error' do
    before { allow(Net::HTTP).to receive(:start).and_raise }
    it     { expect(subject.response).to be nil }
  end
end