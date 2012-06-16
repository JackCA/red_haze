require 'spec_helper'

describe RedHaze do
  describe ".configure" do
    subject { described_class.configure(client_id: 'id') }
    its(:client) { should be_a RedHaze::Client }
  end
end
