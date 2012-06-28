require 'red_haze'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  sensitive_configs = YAML.load_file('config.yml')
  sensitive_configs.each do |k,v|
    c.filter_sensitive_data("<#{k.upcase}>") { v }
  end
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def setup_config
  RedHaze.configure YAML.load_file(File.join(File.dirname(__FILE__),'../config.yml'))
end

class Object
  def boolean?
    !!self == self
  end
end

RSpec::Matchers.define :return_an_array_of do |expected|
  match do |actual|
    actual.class == Array &&
    actual.size == actual.select{|a| a.class == expected}.size
  end
end
