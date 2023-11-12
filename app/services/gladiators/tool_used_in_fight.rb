# frozen_string_literal: true
module Gladiators
  class ToolUsedInFight
    attr_reader :gladiator, :fight

    def initialize(gladiator:, fight:)
      @gladiator = gladiator
      @fight = fight
    end

    def call
      Tool.joins(:tool_gladiator_fights).where(
        'tool_gladiator_fights.gladiator_id = ? AND tool_gladiator_fights.fight_id = ?', gladiator.id, fight.id
      )
    end
  end
end
