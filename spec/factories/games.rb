FactoryBot.define do
  factory :game do
    title              {Faker::Name.initials}
    answer             {Faker::Name.initials}
    association :user
  end
end
