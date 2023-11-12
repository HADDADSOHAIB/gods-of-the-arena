# frozen_string_literal: true
class FightForm
  include ActiveModel::Model
  attr_reader :first_gladiator_id, :second_gladiator_id, :first_gladiator, :second_gladiator, :fight

  #==== Validations ====
  validates :first_gladiator_id, :second_gladiator_id, presence: true
  validate :gladiators_are_different
  validate :check_ids_on_database
  validate :gladiators_in_good_health
  validate :gladiators_has_life_point

  def initialize(first_gladiator_id: nil, second_gladiator_id: nil)
    @first_gladiator_id = first_gladiator_id
    @second_gladiator_id = second_gladiator_id
  end

  def save!
    return false unless valid?

    ActiveRecord::Base.transaction do
      persist_elements
    end

    errors.empty?
  end

  def save
    save!
  rescue StandardError => error
    errors.add(:base, error.message)
    false
  end

  private

  def persist_elements
    @fight = Fight.create!(description: "Fight between #{first_gladiator.name} and #{second_gladiator.name}")
    first_gladiator.gladiator_fights.create!(fight: fight)
    second_gladiator.gladiator_fights.create!(fight: fight)
  end

  def check_ids_on_database
    unless (@first_gladiator = Gladiator.find_by(id: first_gladiator_id))
      errors.add(:base,
                 "Gladiator #{first_gladiator_id} doesn't exist")
    end
    return if (@second_gladiator = Gladiator.find_by(id: second_gladiator_id))

    errors.add(:base,
               "Gladiator #{second_gladiator_id} doesn't exist")
  end

  def gladiators_are_different
    errors.add(:base, 'To start a fight, choose different gladiators') if second_gladiator_id == first_gladiator_id
  end

  def gladiators_in_good_health
    unless first_gladiator.health_status_ready_for_fight?
      errors.add(:base,
                 "Gladiator #{first_gladiator.name} is not in a good health status for a fight")
    end
    return if second_gladiator.health_status_ready_for_fight?

    errors.add(:base,
               "Gladiator #{second_gladiator.name} is not in a good health status for a fight")
  end

  def gladiators_has_life_point
    if first_gladiator.life_points.zero?
      errors.add(:base,
                 "Gladiator #{first_gladiator.name} does not have life point to take part in the fight")
    end
    return unless second_gladiator.life_points.zero?

    errors.add(:base,
               "Gladiator #{second_gladiator.name} does not have life point to take part in the fight")
  end
end
