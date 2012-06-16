require 'spec_helper'

describe RedHaze::Request do
  before(:all) { setup_config }

  specify { described_class.base_uri.should == 'http://api.soundcloud.com'}
  specify { described_class.headers['Accept'].should == 'application/json' }

  let(:instance) { described_class.new(:get, '/users') }

  describe "#initialize" do
    subject { instance }
    its(:type) { should == :get }
    its(:path) { should == '/users' }
    specify { subject.query[:client_id].should_not be_nil }
  end

  describe "#execute" do
    subject { instance }
    it "should call the correct httparty method" do
      described_class.should_receive(:get).with('/users', query: {client_id: anything})
      subject.execute
    end
  end

  describe ".execute" do
    subject { described_class.execute(:get,'/users') }
    it "calls initialize with args and then executes on instance" do
      request = double(described_class)
      described_class.should_receive(:new).with(:get,'/users').and_return(request)
      request.should_receive(:execute)
      subject
    end
  end

end
