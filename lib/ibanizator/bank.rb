require 'equalizer'
require 'adamantium'

class Ibanizator
  class Bank
    include Equalizer.new(:bic, :name, :bank_code)
    include Adamantium

    attr_reader :bic, :name, :bank_code

    def initialize(bic, name, bank_code)
      @bic = bic
      @name = name
      @bank_code = bank_code
    end
  end
end
