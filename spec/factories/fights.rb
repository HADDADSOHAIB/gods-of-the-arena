# frozen_string_literal: true
FactoryBot.define do
  factory :fight do
    description { Faker::Lorem.word }

    trait :with_won_gladiators do
      after(:create) do |fight|
        create_list(:gladiator_fight, 2, fight: fight, battle_won: true)
      end
    end

    trait :with_lost_gladiators do
      after(:create) do |fight|
        create_list(:gladiator_fight, 2, fight: fight, battle_won: false)
      end
    end

    trait :with_planned_gladiators do
      after(:create) do |fight|
        create_list(:gladiator_fight, 2, fight: fight, battle_won: nil)
      end
    end
  end
end
