require 'active_support/time'

describe ApiClient do
  describe '.response' do
    it { expect(subject.response.code).to eq "200"}

    context 'data exists' do
      let(:data_dir)  { Configuration.data_dir }
      let(:data_file) { "d2a23232b050d373d76b474a7f7a4fc6.json" }
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
