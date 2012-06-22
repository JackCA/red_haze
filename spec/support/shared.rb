  shared_examples_for "an array of Users" do
    specify do
      subject.each { |u| u.should be_a RedHaze::User }
    end
  end

  shared_examples_for "an array of Tracks" do
    specify do
      subject.each do |u|
        u.should be_a RedHaze::Track
        u.id.should be_an Integer
      end
    end
  end

  shared_examples_for "an array of Comments" do
    specify do
      subject.each { |u| u.should be_a RedHaze::Comment; u.id.should be_an Integer }
    end
  end

  shared_examples_for "an array of Groups" do
    specify do
      subject.each { |u| u.should be_a RedHaze::Group; u.id.should be_an Integer }
    end
  end
