# frozen_string_literal: true
class Shield < ApplicationRecord
  include Toolable

  #=== Validations ====
  validates :protection_points, presence: true
  validates :protection_points, inclusion: { in: (0...), message: 'should be greater than 0' }
end
