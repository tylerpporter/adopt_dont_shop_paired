require 'rails_helper'

RSpec.describe Favorite do
  subject { Favorite.new(["12", "25"]) }

  describe "#total_count" do
    it "calculates the total number of favorited pets" do
      expect(subject.total_count).to eq(2)
    end
  end

  describe "#add_pet" do
    it "adds a pet to its contents" do
      subject.add_pet("79")

      expect(subject.contents).to eq(["12", "25", "79"])
    end
  end
  describe 'instance methods'
  it 'remove_pet' do
    subject.remove_pet("25")

    expect(subject.contents).to eq(["12"])
  end
end
