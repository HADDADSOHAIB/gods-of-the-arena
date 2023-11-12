# frozen_string_literal: true
module Fights
  class ChooseWinner
    attr_reader :gladiators

    def initialize(gladiators:)
      @gladiators = gladiators
    end

    def call
      raise 'There is no gladiators fightings' if gladiators.empty?

      gladiators.sample
    end
  end
end
