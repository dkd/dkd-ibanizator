require_relative '../errors/invalid_bank_code_error'
require_relative '../errors/bank_not_found_error'

module SwiftBic
  class BankDb
    BANKS = {}.tap do |banks|
      File.open(File.expand_path('../../../db/blz.txt', __FILE__), 'r').each_line do |line|
        code, _, _, _, _, name, _, bic = line.unpack 'A8A1A58A5A35A27A5A11'
        next if bic.empty?
        name.force_encoding('iso-8859-1').encode!('utf-8')
        banks[code] = { name: name, bic: bic }
      end
    end

    def validate_bank_code(bank_code)
      return true if bank_code.length == 8
      raise InvalidBankCodeError
    end
  end
end
