# frozen_string_literal: true
module Fights
  class ToolListByGladiator
    attr_reader :fight

    def initialize(fight:)
      @fight = fight
    end

    def call
      fight.gladiators.map do |gladiator|
        [gladiator, Gladiators::ToolUsedInFight.new(gladiator: gladiator, fight: fight).call]
      end.to_h
    end
  end
end
