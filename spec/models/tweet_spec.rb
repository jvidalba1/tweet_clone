require 'rails_helper'

RSpec.describe Tweet, :type => :model do

  it "is valid with valid attributes" do
    expect(FactoryBot.build(:tweet)).to be_valid
  end

  it "is not valid without a user" do
    expect(FactoryBot.build(:tweet, user: nil)).to be_invalid
  end

  it "is not valid without a body" do
    expect(FactoryBot.build(:tweet, body: nil)).to be_invalid
  end

  it "is not valid with a body longer than 280 characters" do
    expect(FactoryBot.build(:tweet, body: "a"*281)).to be_invalid
  end
end
