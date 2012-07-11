require 'spec_helper'

describe RedHaze::Collection do
  # just need a good example of a collection hash
  let(:raw_hash) do
    setup_config(:oauth)
    VCR.use_cassette('me_activities') do
      RedHaze::Request.get('/me/activities/all')
    end
  end

  let(:instance) { described_class.new(raw_hash) }
  subject { instance }

  its(:items) { should return_an_array_of_red_haze_objects }
  its(:next_href) { should =~ /http/ }
  its(:future_href) { should =~ /http/ }

  describe "#next" do
    subject do
      VCR.use_cassette('collection_next') { instance.next } 
    end
    it{ should be_a described_class }
  end

end
