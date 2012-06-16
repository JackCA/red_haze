require 'spec_helper'

describe RedHaze::User do
  describe "#initialize" do
    subject { described_class.new(999942) }
    specify { should be_a described_class }
    its(:id) { should == 999942 }
  end

  describe "#playlists" do
    pending
  end

  describe "#followings" do
    context "with arg" do
      pending
    end
    context "without arg" do
      pending
    end
  end

  describe "#followers" do
    pending
  end

  describe "#comments" do
    pending
  end

  describe "#groups" do
    pending
  end

  describe "#web_profiles" do
    pending
  end

  describe "#favorites" do
    context "with arg" do
      pending
    end
    context "without arg" do
      pending
    end
  end
end
