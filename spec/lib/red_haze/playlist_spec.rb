require 'spec_helper'
require 'red_haze/playlist'

describe RedHaze::Playlist do
  before(:all) { setup_config(:client) }

  let(:instance) { described_class.new(2161228) }

  describe "#sync" do
    subject { VCR.use_cassette("playlist") { instance.sync } }
    its(:id) { should be_an Integer }
    its(:created_at) { should be_a DateTime }
    its(:user_id) { should be_an Integer }
    its(:user) { should be_a RedHaze::User }
    its(:title) { should be_a String }
    its(:permalink) { should be_a String }
    its(:permalink_url) { should be_a String }
    its(:url) { should be_a String }
    its(:sharing) { should be_a String }
    #its(:purchase_url) { should be_a String }
    #its(:artwork_url) { should be_a String }
    its(:description) { should be_a String }
    #its(:label) { should be_a String }
    its(:duration) { should be_an Integer }
    its(:streamable) { should be_boolean }
    its(:downloadable) { should be_boolean }

  end

  describe "#shared_to_emails" do
    #subject { instance.shared_to_emails }
    #it { should be_an_array_of String }
    pending "need token"
  end

  describe "#shared_to_emails" do
    #subject { instance.shared_to_emails }
    #it { should be_an_array_of String }
    pending "need token"
  end
end
