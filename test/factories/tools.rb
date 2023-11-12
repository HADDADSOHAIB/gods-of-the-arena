# frozen_string_literal: true
FactoryBot.define do
  factory :tool do
    name { 'MyString' }
    toolable { nil }
  end
end
