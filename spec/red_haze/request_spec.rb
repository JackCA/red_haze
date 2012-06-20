require 'spec_helper'

describe RedHaze::Request do
  before(:all) { setup_config }

  specify { described_class.base_uri.should == 'http://api.soundcloud.com'}
  specify { described_class.headers['Accept'].should == 'application/json' }

end
