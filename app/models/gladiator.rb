class Gladiator < ApplicationRecord

  #==== Attributes ====
  enum health_status: { ready_for_fight: 0, recovering_from_fight: 1, dead: 2}, _prefix: true

  #==== Validations ====
  validates :name, :life_points, :attack_points, :magic_points, :health_status, :age, presence: :true
  validates :life_points, :attack_points, :magic_points, inclusion: { in: (0..100), message: 'should be between 0 and 100' }
  validates :age, inclusion: { in: (0...), message: 'should be greater than 0' }
end
