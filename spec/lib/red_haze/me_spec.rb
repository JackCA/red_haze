require 'spec_helper'

describe RedHaze::Me do
  let(:instance) { VCR.use_cassette('me') { described_class.new } }
  let(:friend_id) { 19813607 }
  let(:friend) { RedHaze::User.new(friend_id) }
  subject { instance }

  context "with oauth token " do
    before(:all) { setup_config(:oauth) }

    its(:id) { should == 999942 }
    it { should be_a RedHaze::User }

    shared_examples_for "a follow action" do
      it "accepts a User object" do
        VCR.use_cassette("user_#{method}") do
          subject.send(method, friend)
        end
      end

      it "accepts a user id" do
        VCR.use_cassette("user_#{method}") do
          subject.send(method, friend_id)
        end
      end

      it "fails otherwise" do
        expect { subject.follow!('something') }.to raise_error ArgumentError
      end
    end

    describe "#follow!" do
      let(:method) { 'follow!' }
      it_behaves_like "a follow action"
    end

    describe "#unfollow!" do
      let(:method) { 'unfollow!' }
      it_behaves_like "a follow action"
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

      context "with underscored filter" do
        subject { instance.activities(filter: :tracks_affiliated) }
        specify do
          instance.should_receive(:get_endpoint).with("/activities/tracks/affiliated",anything)
          subject
        end
      end

      context "with bad filter" do
        subject { instance.activities(filter: :bad) }
        specify do
          expect { subject }.to raise_error /bad activities filter/i
        end
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
