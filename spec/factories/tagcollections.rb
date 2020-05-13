FactoryBot.define do
  factory :tagcollection do
    name { Faker::Name.name }

    association :user, factory: :user, strategy: :create
  end
end
