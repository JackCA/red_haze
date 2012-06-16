require 'spec_helper'

describe RedHaze::Client do

  describe "#initialize" do

    context "with client_id " do
      subject { described_class.new(client_id: 'id') }
      its(:client_id) { should == 'id' }
    end
    
  end

end
