require 'spec_helper'

describe Ibanizator::Iban::ExtendedData::DE do
  let(:iban) { Ibanizator::Iban.new('DE68210501700012345678') }
  let(:extended_data) { described_class.new(iban) }

  describe('#initialize') do
    it 'takes an iban as argument' do
      expect(described_class.new(iban).iban).to eq(iban)
    end

    it 'raises an Ibanizator::Iban::Invalid error if the given iban is not valid' do
      iban = instance_double('Ibanizator::Iban', valid?: false)

      expect { described_class.new(iban) }.to raise_error(Ibanizator::Iban::Invalid)
    end
  end

  describe '#bank_code' do
    it 'returns the bank code that is encoded in the iban' do
      expect(extended_data.bank_code).to eq('21050170')
    end
  end

  describe '#account_number' do
    it 'returns the account number that is encoded in the iban withou leading zeros' do
      expect(extended_data.account_number).to eq('12345678')
    end
  end

  describe '#bic' do
    it 'returns the BIC that correlates to the encoded bank code' do
      expect(extended_data.bic).to eq('NOLADE21KIE')
    end
  end

  it 'defines the equality base on the iban' do
    extended_data2 = described_class.new(iban)

    expect(extended_data).to eq(extended_data2)
  end

  it 'makes the object immutable' do
    expect { described_class.new(iban).instance_variable_set(:@iban, nil) }.to raise_error(RuntimeError, /can't modify frozen/)
  end
end
