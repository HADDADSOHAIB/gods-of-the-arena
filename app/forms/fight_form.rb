# frozen_string_literal: true
# rubocop:disable Metrics/ClassLength
class FightForm
  include ActiveModel::Model
  attr_reader :first_gladiator_id, :second_gladiator_id, :first_gladiator, :second_gladiator, :fight,
              :first_gladiator_tool_ids, :second_gladiator_tool_ids, :first_gladiator_tools, :second_gladiator_tools

  #==== Validations ====
  validates :first_gladiator_id, :second_gladiator_id, presence: true
  validate :gladiators_are_different, :check_gladiator_ids_on_database, :gladiators_in_good_health,
           :gladiators_has_life_point

  validate :tools_are_different, :check_tools_ids_on_database

  def initialize(first_gladiator_id: nil, second_gladiator_id: nil, first_gladiator_tool_ids: [],
                 second_gladiator_tool_ids: [])
    @first_gladiator_id = first_gladiator_id
    @second_gladiator_id = second_gladiator_id
    @first_gladiator_tool_ids = first_gladiator_tool_ids
    @second_gladiator_tool_ids = second_gladiator_tool_ids
    @first_gladiator_tools = []
    @second_gladiator_tools = []
  end

  def save!
    return false unless valid?

    ActiveRecord::Base.transaction do
      create_fight
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
    persist_gladiator_fights(gladiators: [first_gladiator, second_gladiator], fight: fight)
    persist_tools(fight: fight, gladiator: first_gladiator, tools: first_gladiator_tools)
    persist_tools(fight: fight, gladiator: second_gladiator, tools: second_gladiator_tools)
  end

  def create_fight
    @fight = Fight.create!(description: "Fight between #{first_gladiator.name} and #{second_gladiator.name}")
  end

  def persist_gladiator_fights(gladiators:, fight:)
    gladiators.each { _1.gladiator_fights.create!(fight: fight) }
  end

  def persist_tools(fight:, gladiator:, tools:)
    tools.each do |tool|
      fight.tool_gladiator_fights.create!(gladiator: gladiator, tool: tool)
    end
  end

  def check_gladiator_ids_on_database
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

  def tools_are_different
    return unless (first_gladiator_tool_ids & second_gladiator_tool_ids).filter(&:present?).any?

    errors.add(:base,
               'Gladiators are not allowed to use the same tools')
  end

  def check_tools_ids_on_database
    check_first_tools_ids_on_database
    check_second_tools_ids_on_database
  end

  def check_first_tools_ids_on_database
    first_gladiator_tool_ids.filter(&:present?).each do |id|
      if (tool = Tool.find_by(id: id))
        first_gladiator_tools << tool
      else
        errors.add(:base,
                   "Tool #{id} doesn't exist")
      end
    end
  end

  def check_second_tools_ids_on_database
    second_gladiator_tool_ids.filter(&:present?).each do |id|
      if (tool = Tool.find_by(id: id))
        second_gladiator_tools << tool
      else
        errors.add(:base,
                   "Tool #{id} doesn't exist")
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
