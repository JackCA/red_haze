require 'spec_helper'

describe RedHaze do
  describe ".configure" do
    subject { described_class.configure(client_id: 'id', client_secret: 'secret') }
    its(:client) { should be_a RedHaze::Client }
  end

  describe ".configure_from_file" do
    subject { described_class.configure_from_file 'config.template.yml' }
    its(:client) { should be_a RedHaze::Client }
  end
end
