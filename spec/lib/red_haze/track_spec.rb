require 'spec_helper'

describe RedHaze::Track do
  before(:all) { setup_config(:client) }

  let(:instance) { described_class.new(49518905) }
  let(:synced_track) do 
      VCR.use_cassette('track_sync') { instance.sync }
  end

  describe "#initialize" do
    subject { instance }
    specify { should be_a described_class }
    its(:id) { should == 49518905 }
  end

  describe "#tag_list" do
    pending
  end

  describe "#sync" do
    subject { synced_track }

    its(:created_at) { should be_a DateTime }
    its(:user_id) { should be_an Integer }
    its(:user) { should be_a RedHaze::User }
    its(:title) { should be_a String }
    its(:permalink) { should be_a String }
    its(:permalink_url) { should =~ /http:\/\/soundcloud.com/ }
    its(:uri) { should =~ /http:\/\/api.soundcloud.com/ }
    its(:sharing) { should be_a String }
    its(:purchase_url) { should =~ /http:\/\// }
    its(:artwork_url) { should =~ /http:\/\/.*\.jpg/ }
    its(:description) { should be_a String }
    its(:duration) { should be_an Integer }
    its(:genre) { should be_a String }
    its(:label_name) { should be_a String }
    its(:license) { should be_a String }
    its(:release) { should be_a String }
    its(:streamable) { should be_boolean }
    its(:downloadable) { should be_boolean }
    its(:state) { should be_a String }
    its(:waveform_url) { should =~ /http:\/\/.*\.png/ }
    its(:commentable) { should be_boolean }
    its(:comment_count) { should be_an Integer }
    its(:download_count) { should be_an Integer }
    its(:playback_count) { should be_an Integer }
    its(:favoritings_count) { should be_an Integer }
    its(:original_format) { should be_a String }
    its(:original_content_size) { should be_an Integer }

    #no test data
    #its(:label_id) { should be_nil }
    #its(:release_day) { should be_nil }
    #its(:release_month) { should be_nil }
    #its(:release_year) { should be_nil }
    #its(:track_type) { should be_nil }
    #its(:bpm) { should be_nil }
    #its(:isrc) { should be_nil  }
  end

  describe "#comments" do
    subject do 
      VCR.use_cassette("track_comments") { instance.comments }
    end

    it { should return_an_array_of RedHaze::Comment }
  end

  describe "#favoriters" do
    subject do
      VCR.use_cassette('track_favoriters') { instance.favoriters }
    end
    it { should return_an_array_of RedHaze::User }
  end

  describe "#shared_to" do
    pending "Do not have any actual data for this"
    #subject do
    #  VCR.use_cassette('track_shared_tos') { instance.shared_to }
    #end
    #it { should be_an_array_of RedHaze::Track }
  end

  describe "#secret_token" do
    pending
  end

  describe "#comment" do
    pending
  end
end
