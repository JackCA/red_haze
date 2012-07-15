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

    shared_examples_for "an ambiguous id argument" do
      before do
        @vcr_name = "#{klass}_#{method}".sub('?','_get').sub('!','_put')
      end

      it "accepts an object" do
        VCR.use_cassette(@vcr_name) do
          instance.send(method, friend)
        end
      end

      it "accepts an id" do
        VCR.use_cassette(@vcr_name) do
          instance.send(method, friend_id)
        end
      end

      it "fails otherwise" do
        expect { instance.send(method,'something') }.to raise_error ArgumentError
      end
    end

    context "follow actions" do
      let(:klass) { 'user' }
      pending "application test"
      describe "#follow!" do
        let(:method) { 'follow!' }
        it_behaves_like "an ambiguous id argument"
      end

      describe "#unfollow!" do
        let(:method) { 'unfollow!' }
        it_behaves_like "an ambiguous id argument"
      end

      describe "#follows?" do
        let(:method) { 'follows?' }
        it_behaves_like "an ambiguous id argument"
      end
    end

    context "favorite actions" do
      let(:klass) { 'track' }
      let(:track_id) { 8774929 } 

      describe "#favorite?" do
        let(:method) { 'favorite?' }
        subject { instance.favorite?(track_id) }
        it_behaves_like "an ambiguous id argument"
      end

      describe "#favorite!" do
        let(:method) { 'favorite!' }
        subject { instance.favorite?(track_id) }
        it_behaves_like "an ambiguous id argument"
      end

      describe "#unfavorite!" do
        let(:method) { 'unfavorite!' }
        subject { instance.unfavorite!(track_id) }
        it_behaves_like "an ambiguous id argument"
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
