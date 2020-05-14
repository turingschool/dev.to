FactoryBot.define do
  factory :machine_collection do
    user
    title { Faker::Name.unique.name }

  end
end
