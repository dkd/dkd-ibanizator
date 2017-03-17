require_relative '../../lib/ibanizator'
require_relative '../../lib/swift_bic/bank_db'
require_relative '../../lib/errors/invalid_bank_code_error'

describe SwiftBic::BankDb do
  let(:bank_db) { described_class.new }

  describe '#validate_bank_code' do
    context 'given valid german bank code' do
      it 'returns true' do
        expect(bank_db.validate_bank_code('10000000')).to eq(true)
      end
    end

    context 'given invalid bank code' do
      it 'raises an invalid bank code exception' do
        expect { bank_db.validate_bank_code '123' }.to raise_error(InvalidBankCodeError)
      end
    end
  end
end
