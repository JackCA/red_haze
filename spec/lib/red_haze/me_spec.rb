require 'spec_helper'

describe RedHaze::Me do
  let(:instance) { VCR.use_cassette('me') { described_class.new } }
  subject { instance }

  context "with oauth token " do
    before(:all) { setup_config(:oauth) }

    its(:id) { should == 999942 }
    it { should be_a RedHaze::User }

    describe "#follow!" do
      it "accepts a User object" do
        instance.follow!(instance)
      end
      it "accepts a user id" do
        instance.follow!(1234)
      end

      it "fails otherwise" do
        expect { instance.follow! }.to raise_error ArgumentError
      end
    end

    describe "#activities" do
      subject do
        VCR.use_cassette("me_activities") { instance.activities }
      end
      it { should be_a RedHaze::Collection }

      context "with limit" do
        subject do
          VCR.use_cassette("me_activities_limit") { instance.activities(limit: 10) }
        end
        its(:items) { subject.size.should == 10 }
      end

    end
  end

  context "without access token" do
    before(:all) { setup_config(:client) }
    specify do
      expect { subject }.to raise_error /access_token/
    end
  end

end
