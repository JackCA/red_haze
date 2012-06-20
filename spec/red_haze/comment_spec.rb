require 'spec_helper'

describe RedHaze::Comment do
  before(:all) { setup_config }

  let(:instance) { described_class.new(13685794) }

  describe "#initialize" do
    subject { instance }
    it { should be_a described_class }
    its(:id) { should == 13685794 }
  end

  describe "#sync" do
    subject do 
      VCR.use_cassette("comment_sync") { instance.sync }
    end

    it { should be_a described_class }
    its(:created_at) { should be_a DateTime }
    its(:user_id) { should be_a Integer }
    its(:track_id) { should be_a Integer }
    its(:timestamp) { should be_a Integer }
    its(:body) { should be_a String }
    its(:uri) { should =~ /http:\/\/api.soundcloud.com/ }
    its(:user) { should be_a RedHaze::User }
  end

end

