require 'spec_helper'

describe RedHaze::User do
  before(:all) { setup_config }

  let(:instance) { described_class.new(999942) }

  describe "#initialize" do
    subject { instance }
    specify { should be_a described_class }
    its(:id) { should == 999942 }
  end

  describe "#sync" do
    subject do
      VCR.use_cassette('user_sync') { instance.sync }
    end
    it { should be_a described_class }
    its(:permalink)         { should be_a String }
    its(:username)          { should be_a String }
    its(:uri)               { should =~ /http:\/\/api.soundcloud.com\/*/ }
    its(:permalink_url)     { should =~ /http:\/\/soundcloud.com\/*/ }
    its(:avatar_url)        { should =~ /http:\/\/.*.jpg/ }
    its(:country)           { should be_a String }
    its(:full_name)         { should be_a String }
    its(:city)              { should be_a String }
    its(:description)       { should be_a String }
    its(:website)           { should be_a String }
    its(:online)            { should be_boolean }
    its(:track_count)       { should be_an Integer }
    its(:playlist_count)    { should be_an Integer }
    its(:followers_count)   { should be_an Integer }
    its(:followings_count)  { should be_an Integer }
    its(:public_favorites_count)  { should be_an Integer }

    # no real data for these
    its(:discogs_name)    { should be_nil }
    its(:myspace_name)    { should be_nil }
    its(:website_title)   { should be_empty }
  end

  describe "#playlists" do
    subject do
      VCR.use_cassette('user_playlists') { instance.playlists }
    end
    it_should_behave_like "an array of Playlists"
  end

  describe "#followings" do
    context "with arg" do
      context "valid followings user id" do
        subject do
          VCR.use_cassette("user_followings_valid_id") do
            instance.followings(903649)
          end
        end
        #it_should_behave_like "an array of Users"
        pending "need authorization"
      end
    end

    context "without arg" do
      subject do
        VCR.use_cassette("user_followings") { instance.followings }
      end
      it_should_behave_like "an array of Users"
    end
  end

  describe "#followers" do
    subject do
      VCR.use_cassette('user_followers') { instance.followers }
    end
    it_should_behave_like "an array of Users"
  end

  describe "#comments" do
    subject do
      VCR.use_cassette('user_comments') { instance.comments }
    end
    it_should_behave_like "an array of Comments"
  end

  describe "#groups" do
    subject do
      VCR.use_cassette('user_groups') { instance.groups }
    end
    it_should_behave_like "an array of Groups"
  end

  describe "#web_profiles" do
    pending
  end

  describe "#favorites" do
    context "with arg" do
      pending "need authentication"
    end
    context "without arg" do
      subject do
        VCR.use_cassette("user_favorites") { instance.favorites }
      end

      it_should_behave_like "an array of Tracks"
    end
  end
end
