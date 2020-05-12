FactoryBot.define do
  factory :machine_collection do
    user
    title { Faker::Name.unique.name }
    tags { Faker::Hipster.words(number: 4).join(", ") }
  end
end
