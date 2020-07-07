FactoryBot.define do
  factory :user do
    username { 'test' }
    email {'test@sample.com'}
    full_name {'Test Full'}
    password {'testing2020'}
    password_confirmation {'testing2020'}
  end
end
