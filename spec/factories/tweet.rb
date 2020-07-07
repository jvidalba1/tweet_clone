FactoryBot.define do
  factory :tweet do
    body { 'tweet tin tin ...' }
    user { FactoryBot.create(:user) }
  end
end
