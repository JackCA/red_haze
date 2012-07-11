require 'spec_helper'

describe RedHaze::Activity do
  let(:raw_hash) do
    setup_config(:oauth)
    VCR.use_cassette('me_activities') do
      RedHaze::Request.get('/me/activities/all')['collection'].sample
    end
  end

  let(:instance) { described_class.new(raw_hash) }
  subject { instance }

  its(:type) { should be_a String }
  its(:created_at) { should be_a DateTime }
  its(:origin) { subject.class.name.should =~ /RedHaze/ }

  pending "tags array"

end
