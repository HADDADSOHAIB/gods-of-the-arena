# frozen_string_literal: true
FactoryBot.define do
  factory :gladiator do
    name { Faker::Name.name }
    age { Faker::Number.between(from: 1, to: 100) }

    trait :with_won_fights do
      after(:create) do |gladiator|
        create_list(:gladiator_fight, 2, gladiator: gladiator, battle_won: true)
      end
    end

    trait :with_lost_fights do
      after(:create) do |gladiator|
        create_list(:gladiator_fight, 2, gladiator: gladiator, battle_won: false)
      end
    end

    trait :with_planned_fights do
      after(:create) do |gladiator|
        create_list(:gladiator_fight, 2, gladiator: gladiator, battle_won: nil)
      end
    end
  end
end
