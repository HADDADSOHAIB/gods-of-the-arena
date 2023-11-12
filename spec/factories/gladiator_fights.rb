# frozen_string_literal: true
FactoryBot.define do
  factory :gladiator_fight do
    battle_won { [true, false, nil].sample }

    association :gladiator
    association :fight
  end
end
