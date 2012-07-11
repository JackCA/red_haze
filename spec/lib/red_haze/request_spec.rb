require 'spec_helper'

describe RedHaze::Request do

  context "oauth request" do
    before(:all) { setup_config(:oauth) }
    specify { described_class.base_uri.should == 'https://api.soundcloud.com'}
  end

  context "non-oauth request" do
    before(:all) { setup_config(:client) }
    specify { described_class.base_uri.should == 'http://api.soundcloud.com'}
  end

  specify { described_class.headers['Accept'].should == 'application/json' }

end
