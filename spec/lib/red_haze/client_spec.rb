require 'spec_helper'

describe RedHaze::Client do

  let(:instance) { described_class.new(client_id: 'id', client_secret: 'secret') }

  describe "#initialize" do
    context "with client and secret keys" do
      subject { instance }
      its(:client_id) { should == 'id' }
      its(:client_secret) { should == 'secret' }
    end

    context "with only access token" do
      subject { described_class.new(access_token: 'token') }
      its(:access_token) { should == 'token' }
    end

    context "with missing keys" do
      subject { described_class.new(client_secret: 'secret') }
      specify do
        expect { subject }.to raise_error /missing client_id/
      end
    end
  end

  describe "#authorize_url" do
    context "with right attributes" do
      let(:instance_with_response_uri) do
        instance.redirect_uri = 'uri'
        instance
      end
      subject { instance_with_response_uri.authorize_url }
      it { subject.should =~ /https:\/\/soundcloud\.com\/connect\?client_id=.+&redirect_uri=.+&response_type=code/ }
    end

    context "without right attributes" do
      subject { instance.authorize_url }
      specify { expect { subject }.to raise_error }
    end
  end

end
