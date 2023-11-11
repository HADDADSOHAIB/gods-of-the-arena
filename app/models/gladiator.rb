class Gladiator < ApplicationRecord

  #==== Attributes ====
  enum health_status: { ready_for_fight: 0, recovering_from_fight: 1, dead: 2}, _prefix: true

  has_one_attached :avatar

  #==== Validations ====
  validates :name, :life_points, :attack_points, :magic_points, :health_status, :age, presence: :true
  validates :life_points, :attack_points, :magic_points, inclusion: { in: (0..100), message: 'should be between 0 and 100' }
  validates :age, inclusion: { in: (0...), message: 'should be greater than 0' }

  #==== Instance methods ====
  def health_status_human
    I18n.t("gladiators.attributes.health_status.#{health_status}")
  end

  #==== Class methods ====

  def self.health_status_human_wrapper
    health_statuses.map{|(k, v)|[k, I18n.t("gladiators.attributes.health_status.#{k}")]}
  end
end
