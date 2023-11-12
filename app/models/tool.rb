# frozen_string_literal: true
class Tool < ApplicationRecord
  #==== Associations ====
  delegated_type :toolable, types: %w[Shield Weapon]
  has_many :tool_gladiator_fights, dependent: :nullify
end
