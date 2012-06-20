require 'spec_helper'

describe RedHaze::Track do
  before(:all) { setup_config }

  let(:instance) { described_class.new(49518905) }

  describe "#initialize" do
    subject { instance }
    specify { should be_a described_class }
    its(:id) { should == 49518905 }
  end

  describe "#tag_list" do
    pending
  end

  describe "#sync" do
    subject do 
      VCR.use_cassette('track_sync') { instance.sync }
    end
    its(:created_at) { should be_a DateTime }
    its(:user_id) { should be_an Integer }
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
    its(:label_id) { should be_nil }
    its(:release_day) { should be_nil }
    its(:release_month) { should be_nil }
    its(:release_year) { should be_nil }
    its(:track_type) { should be_nil }
    its(:bpm) { should be_nil }
    its(:isrc) { should be_nil  }
  end

  describe "#comments" do
    subject do 
      VCR.use_cassette("track_comments") { instance.comments }
    end

    it_should_behave_like "an array of Comments"

  end

  describe "#favoriters" do
    subject do
      VCR.use_cassette('track_favoriters') { instance.favoriters }
    end
    it_should_behave_like "an array of Users"
  end

  describe "#shared_to" do
    pending
  end

  describe "#secret_token" do
    pending
  end

  describe "#owner" do
    pending
  end
end
