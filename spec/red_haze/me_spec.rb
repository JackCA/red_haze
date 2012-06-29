require 'spec_helper'

describe RedHaze::Me do
  before(:all) { setup_config(:oauth) }

  subject { VCR.use_cassette('me') { described_class.new } }

  its(:id) { should == 999942 }
end
