require 'rails_helper'

RSpec.describe User, :type => :model do

  it "is valid with valid attributes" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is not valid without a username" do
    expect(FactoryBot.build(:user, username: nil)).to be_invalid
  end

  it "is not valid without a email" do
    expect(FactoryBot.build(:user, email: nil)).to be_invalid
  end

  it "is not valid if username has already been taken" do
    FactoryBot.create(:user)
    expect(FactoryBot.build(:user, username: 'test')).to be_invalid
  end

  it "is not valid if email has already been taken" do
    FactoryBot.create(:user)
    expect(FactoryBot.build(:user, email: 'test@sample.com')).to be_invalid
  end
end
