require 'red_haze'
require 'vcr'
require 'support/shared'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
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
