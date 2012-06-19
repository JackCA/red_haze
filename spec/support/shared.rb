  shared_examples_for "an array of Users" do
    specify do
      subject.each { |u| u.should be_a RedHaze::User }
    end
  end

  shared_examples_for "an array of Tracks" do
    specify do
      subject.each { |u| u.should be_a RedHaze::Track }
    end
  end
