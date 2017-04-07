# dkd-ibanizator [![Build Status](https://travis-ci.org/dkd/dkd-ibanizator.svg?branch=master)](https://travis-ci.org/dkd/dkd-ibanizator) [![Gem Version](https://badge.fury.io/rb/dkd-ibanizator.svg)](https://badge.fury.io/rb/dkd-ibanizator) [![Coverage Status](https://coveralls.io/repos/github/dkd/dkd-ibanizator/badge.svg?branch=develop)](https://coveralls.io/github/dkd/dkd-ibanizator?branch=develop)

dkd-ibanizator calculates the IBAN for German bank accounts. The database that is used to convert a bank number to a BIC is taken from [Deutsche Bundesbank](http://www.bundesbank.de/Redaktion/EN/Standardartikel/Tasks/Payment_systems/bank_sort_codes_download.html).

## Installation

Add this line to your application's Gemfile:

```ruby
    gem 'dkd-ibanizator'
```

## Usage

### Calculate IBAN

Load dkd-ibanizator:

```ruby
    require 'ibanizator'
```

To calculate the IBAN for some German bank accounts, just use this method:

```ruby
    ibanizator = Ibanizator.new
    ibanizator.calculate_iban country_code: :de, bank_code: '12345678', account_number: '123456789'
```

Note: In the current version the dkd-ibanizator gem only works for German bank accounts.

### Validate an IBAN

To validate the IBAN you need to check the length and after this check the checksum. For details please refer to the documentation online (e.g. http://es.wikipedia.org/wiki/IBAN).

This gem provides a simple validator for several contries. All countries that are listed in the Ibanizator::Iban::COUNTRY_CODES hash are supported at the moment.

```ruby
    iban = Ibanizator.iban_from_string("DE68 2105 0170 0012 3456 78")
    iban.valid? # => true
```

### Information provided by an IBAN

The Ibanizator::Iban class provides some handy utility methods to query information about an iban.

```ruby
    iban = Ibanizator.iban_from_string("DE68 2105 0170 0012 3456 78")
    iban.country_code # => :DE

    # there is extended data for german ibans
    iban.extended_data.bank_code        # => "21050170"
    iban.extended_data.account_number   # => "12345678"
    iban.extended_data.bic              # => "NOLADE21KIE"
```

### Find bank infos

If you need to get a bank name, bank code or a BIC from a German bank and you have either a BIC or a bank code there is a bank db.

```ruby
    # find a bank by BIC
    bank_1 = Ibanizator.bank_db.bank_by_bic('MARKDEF1100')
    bank_1.name       # => 'BBk Berlin'
    bank_1.bic        # => 'MARKDEF1100'
    bank_1.bank_code  # => '10000000'

    # find a bank by bank_code (de: Bankleitzahl)
    bank_2 = Ibanizator.bank_db.bank_by_bank_code('100 000 00')
    bank_2.name       # => 'BBk Berlin'
    bank_2.bic        # => 'MARKDEF1100'
    bank_2.bank_code  # => '10000000'

    bank_3 = Ibanizator.bank_db.bank_by_bank_code('10000000')
    bank_3.name       # => 'BBk Berlin'
    bank_3.bic        # => 'MARKDEF1100'
    bank_3.bank_code  # => '10000000'

    bank_1 == bank_2  # => true
    bank_2 == bank_3  # => true

    bank_4 = Ibanizator.bank_db.bank_by_bic('OASPDE6AXXX')
    bank_4 == bank_2  # => false
```

## Licence

The code is based on the GitHub project [softwareinmotion/ibanizator](https://github.com/softwareinmotion/ibanizator) and availiable under the MIT licence. 
