require 'spec_helper'

describe RedHaze::Client do

  describe "#initialize" do
    context "with right keys" do
      subject { described_class.new(client_id: 'id', client_secret: 'secret') }
      its(:client_id) { should == 'id' }
    end

    context "with missing keys" do
      subject { described_class.new(client_secret: 'secret') }
      specify do
        expect { subject }.to raise_error /missing client_id or client_secret/
      end
    end
    
  end

end
