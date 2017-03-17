Gem::Specification.new do |s|
  s.name = 'dkd-ibanizator'
  s.version = '0.9.0'.freeze
  s.date = '2017-03-17'
  s.licenses = ['MIT']

  s.summary = 'An IBAN generator/validator and BIC generator for German bank accounts.'
  s.description = <<-EOD.gsub(/\s+/, ' ')
    dkd-ibanizator generates the correct IBAN for a given account number and bank number
    for German bank accounts. It is possible to validate given IBAN codes.
    Calculates also the BIC and bank names for given German bank codes.
  EOD
  s.homepage = 'https://github.com/dkd/dkd-ibanizator'

  s.authors = ['Nicolai Reuschling']
  s.email = 'nicolai.reuschling@dkd.de'

  s.files = Dir.glob('lib/**/*') + %w(license.md README.md db/blz.txt)

  s.add_dependency 'equalizer', '~> 0.0.11'
  s.add_dependency 'adamantium', '~> 0.2.0'

  s.add_development_dependency 'rake', '~> 12.0.0'
  s.add_development_dependency 'bundler', '~> 1.14.6'
  s.add_development_dependency 'rspec', '~> 3.5.0'
  s.add_development_dependency 'rubocop', '~> 0.47.1'
  s.add_development_dependency 'rubocop-rspec', '~> 1.13.0'
  s.add_development_dependency 'guard-rspec', '~> 4.7.3'
  s.add_development_dependency 'guard-rubocop', '~> 1.2.0'
  s.add_development_dependency 'terminal-notifier', '~> 1.7.1'
  s.add_development_dependency 'terminal-notifier-guard', '~> 1.7.0'
end
