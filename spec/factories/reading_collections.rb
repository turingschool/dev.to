FactoryBot.define do
  factory :reading_collection do
    sequence(:name) { |n| "#{Faker::Book.title}#{n}" }
    association :user, factory: :user, strategy: :create
  end
end
