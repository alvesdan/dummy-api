require './app/models/dummy_api/response'

module DummyApi
  RSpec.describe Response do

    let(:settings) do
      {
        data: {
          users: {
            fields: [
              { name: :name },
              { email: :email }
            ]
          }
        },
        page: 1,
        per_page: 10,
        total: 95
      }
    end
    let(:email_regex) { /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }

    subject { described_class.new(settings) }

    it 'generates a correct API response' do
      response_hash = subject.to_hash

      response_hash[:users].each do |user|
        expect(user[:email]).to match(email_regex)
      end
    end

    describe 'rows count' do
      context 'when on first page' do
        before { settings[:page] = 1 }
        it 'generates 10 rows' do
          expect(subject.to_hash[:users].size).to eq 10
        end
      end

      context 'when on second page' do
        before { settings[:page] = 2 }
        it 'generates 10 rows' do
          expect(subject.to_hash[:users].size).to eq 10
        end
      end

      context 'when on page 10' do
        before { settings[:page] = 10 }
        it 'generates 5 rows' do
          expect(subject.to_hash[:users].size).to eq 5
        end
      end

      context 'when on page 11' do
        before { settings[:page] = 11 }
        it 'generates 0 rows' do
          expect(subject.to_hash[:users].size).to eq 0
        end
      end
    end

  end
end
