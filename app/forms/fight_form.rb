class FightForm
  include ActiveModel::Model
  attr_reader :first_gladiator_id, :second_gladiator_id, :first_gladiator, :second_gladiator, :fight

  #==== Validations ====
  validates :first_gladiator_id, :second_gladiator_id, presence: true
  validate :gladiators_are_different
  validate :check_ids_on_database
  validate :gladiators_in_good_health

  def initialize(first_gladiator_id: nil, second_gladiator_id: nil)
    @first_gladiator_id = first_gladiator_id
    @second_gladiator_id = second_gladiator_id
  end

  def check_ids_on_database
    errors.add(:base, "Gladiator #{first_gladiator_id} doesn't exist") unless (@first_gladiator = Gladiator.find_by(id: first_gladiator_id))
    errors.add(:base, "Gladiator #{second_gladiator_id} doesn't exist") unless (@second_gladiator = Gladiator.find_by(id: second_gladiator_id))
  end

  def gladiators_are_different
    errors.add(:base, "To start a fight, choose different gladiators") if second_gladiator_id == first_gladiator_id
  end
  
  def gladiators_in_good_health
    errors.add(:base, "Gladiator #{first_gladiator.name} is not in a good health status for a fight") unless first_gladiator.health_status_ready_for_fight?
    errors.add(:base, "Gladiator #{second_gladiator.name} is not in a good health status for a fight") unless second_gladiator.health_status_ready_for_fight?
  end

  def save!
    return false unless valid?

    ActiveRecord::Base.transaction do
      @fight = Fight.create!(description: "Fight between #{first_gladiator.name} and #{second_gladiator.name}")
      first_gladiator.gladiator_fights.create!(fight:)
      second_gladiator.gladiator_fights.create!(fight:)
    end

    errors.empty?
  end

  def save
    save!
  rescue => e
    errors.add(:base, e.message)
    false
  end
end