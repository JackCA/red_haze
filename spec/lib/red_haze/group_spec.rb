require 'spec_helper'

describe RedHaze::Group do
  before(:all) { setup_config(:client) }

  let(:instance) { described_class.new(83495) }

  describe "#initialize" do
    subject { instance }
    it { should be_a described_class }
    its(:id) { should == 83495 }
  end

  describe "#sync" do
    subject do
      VCR.use_cassette("group_sync") { instance.sync }
    end
    its(:uri) { should =~ /http:\/\/api.soundcloud.com/ }
    its(:created_at) { should be_a DateTime }
    its(:permalink) { should be_a String }
    its(:permalink_url) { should =~ /http:\/\/soundcloud.com/ }
    its(:artwork_url) { should =~ /http:\/\/.*\.(jpg|png)/ }
    its(:name) { should be_a String }
    its(:description) { should be_a String }
    its(:short_description) { should be_a String }
    its(:creator) { should be_a RedHaze::User }
  end

  describe "#members" do
    subject do
      VCR.use_cassette("group_members") { instance.members }
    end
    it { should return_an_array_of RedHaze::User }
  end

  describe "#moderators" do
    subject do
      VCR.use_cassette("group_moderators") { instance.moderators }
    end
    it { should return_an_array_of RedHaze::User }
  end

  describe "#contributors" do
    subject do
      VCR.use_cassette("group_contributors") { instance.contributors }
    end
    it { should return_an_array_of RedHaze::User }
  end

  describe "#users" do
    subject do
      VCR.use_cassette("group_users") { instance.users }
    end
    it { should return_an_array_of RedHaze::User }
  end

end
