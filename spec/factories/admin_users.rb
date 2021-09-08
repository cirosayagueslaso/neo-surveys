FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.email }
    encrypted_password { Faker::Internet.password }
  end
end
