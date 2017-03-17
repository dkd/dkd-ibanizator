require 'spec_helper'

describe Ibanizator do
  let(:ibanizator) { described_class.new }

  describe '#calculate_iban' do
    context 'given correct parameters' do
      let(:options) { { country_code: :de, bank_code: '12345678', account_number: '123456789' } }

      it 'calculates the correct checksum' do
        expect(ibanizator.calculate_iban(options)[2..3]).to eq('58')
      end

      context 'given parameters producing a one sign checksum' do
        let(:options) { { country_code: :de, bank_code: '10000000', account_number: '11111' } }

        it 'calculates the correct checksum and prepends zero' do
          expect(ibanizator.calculate_iban(options)[2..3]).to eq('04')
        end
      end

      it 'strings the given parameters in the correct way' do
        expect(ibanizator.calculate_iban(options)).to eq('DE58123456780123456789')
      end

      context 'given an account number with eight digits' do
        before do
          options[:account_number] = '12345678'
        end

        it 'fills the account number to ten digits' do
          expect(ibanizator.calculate_iban(options)[12..21]).to eq('0012345678')
        end
      end
    end

    context 'given bank code and account number with spaces' do
      let(:options) { { country_code: :de, bank_code: '123 456 78', account_number: '123 456 789' } }

      it 'strips spaces and still calculates the currect checksum' do
        expect(ibanizator.calculate_iban(options)[2..3]).to eq('58')
      end
    end

    context 'given wrong bank code' do
      it 'throws an exception'
    end

    context 'given to long account number' do
      it 'throws an exception'
    end

    context 'given other country code than :de' do
      it 'throws an exception'
    end
  end

  describe '#character_to_digit' do
    context 'given :de as country code' do
      it 'calculates 1314 as numeral country code' do
        expect(ibanizator.character_to_digit('de')).to eq('1314')
      end
    end
  end

  describe '.bank_db' do
    it 'returns a BankDB' do
      expect(described_class.bank_db).to be_a(Ibanizator::BankDb)
    end
  end

  describe '.iban_from_string(a_string)' do
    it 'returns an Ibanizator::Iban' do
      expect(described_class.iban_from_string('an_iban')).to be_a(Ibanizator::Iban)
    end

    it 'delegates the object construction to Ibanizator::Iban.from_string' do
      expect(Ibanizator::Iban).to receive(:from_string).with('a_string')

      described_class.iban_from_string('a_string')
    end
  end
end
