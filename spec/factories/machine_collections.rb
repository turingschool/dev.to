FactoryBot.define do
  factory :machine_collection do
    user
    sequence(:title) { |n| "Collection-#{n}" }
    cached_tag_list { "tagged-interest" }
    slug { "random-generated-slug" }
  end
end
