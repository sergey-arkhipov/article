FactoryBot.define do
  factory :article do
    sequence(:author) { |n| "Иванов #{n + 1} Иван #{n + 1} Иванович #{n + 1}" }
    sequence(:title) { |n| "Smith#{n} #{n}  #{Faker::Lorem.sentence}" }
  end
  trait :with_text do
    after(:create) do |article|
      create_list(:text, 10, article:)
    end
  end
end

FactoryBot.define do
  factory :text do
    text { |n| "#{n} #{Faker::Lorem.paragraph}" }
    changed_on { |n| "2019-04-#{n} 13:33:05" }
  end
end
