require 'spec_helper'

describe RedHaze::Response do
  before { setup_config }
  let(:request) do
    VCR.use_cassette('test') { RedHaze::Request.execute(:get,'/users') }
  end

end
