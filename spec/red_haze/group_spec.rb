require 'spec_helper'

describe RedHaze::Group do
  before(:all) { setup_config }

  let(:instance) { described_class.new(3) }

  describe "#initialize" do
    subject { instance }
    it { should be_a described_class }
    its(:id) { should == 3 }
  end

  describe "#sync" do
    subject do
      VCR.use_cassette("group_sync") { instance.sync }
    end
    its(:uri) { should =~ /http:\/\/api.soundcloud.com/ }
    its(:created_at) { should be_a DateTime }
    its(:permalink) { should be_a String }
    its(:permalink_url) { should =~ /http:\/\/soundcloud.com/ }
    its(:artwork_url) { should =~ /http:\/\/.*\.jpg/ }
    its(:name) { should be_a String }
    its(:description) { should be_a String }
    its(:short_description) { should be_a String }
    its(:creator) { should be_a RedHaze::User }
  end

end
