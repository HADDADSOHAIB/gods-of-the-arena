# frozen_string_literal: true
class Weapon < ApplicationRecord
  include Toolable

  #=== Validations ====
  validates :attack_points, presence: true
  validates :attack_points, inclusion: { in: (0...), message: 'should be greater than 0' }
end
