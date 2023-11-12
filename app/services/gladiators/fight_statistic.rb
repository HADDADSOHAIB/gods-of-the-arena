module Gladiators
  class FightStatistic
    attr_reader :gladiator

    def initialize(gladiator:)
      @gladiator = gladiator
    end

    def number_of_fights
      gladiator.fights.count
    end

    def number_of_lost_fights
      gladiator.lost_fights.count
    end

    def number_of_won_fights
      gladiator.won_fights.count
    end

    def number_of_planned_fights
      gladiator.planned_fights.count
    end

    def winning_ratio
      return 0 if number_of_fights.zero?

      (number_of_won_fights.to_f / number_of_fights).round(2)
    end
  end
end