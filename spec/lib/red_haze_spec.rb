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

  shared_examples_for "a convenience class accessor" do
    subject { described_class.send(klass, 1111) }
    it { should be_a eval("RedHaze::#{klass.capitalize}") }
  end

  describe ".user" do
    let(:klass) {:user}
    it_should_behave_like  "a convenience class accessor"
  end

  describe ".track" do
    let(:klass) {:track}
    it_should_behave_like  "a convenience class accessor"
  end

  describe ".group" do
    let(:klass) {:group}
    it_should_behave_like  "a convenience class accessor"
  end

  describe ".playlist" do
    let(:klass) {:playlist}
    it_should_behave_like  "a convenience class accessor"
  end

  describe ".comment" do
    let(:klass) {:comment}
    it_should_behave_like  "a convenience class accessor"
  end

end
