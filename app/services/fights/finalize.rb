module Fights
  class Finalize
    AFTER_FIGHT_STATUS = ['recovering_from_fight', 'dead'].freeze
    attr_reader :the_winner, :the_loosers

    def initialize(fight:, the_winner:, the_loosers:)
      @the_winner = the_winner
      @the_loosers = the_loosers
    end

    def call
      the_winner.update!(life_points: the_winner.life_points / 2)
      the_winner_gladiator_fight = the_winner.gladiator_fights.find_by(fight:)
      raise "There is non record of this gladiator #{the_winner.name} in this fight" unless the_winner_gladiator_fight

      the_winner_gladiator_fight.update!(battle_won: true)

      the_loosers.each do |the_looser|
        the_looser.update!(life_points: 0, health_status: AFTER_FIGHT_STATUS.sample)
        the_looser_gladiator_fight = the_winner.gladiator_fights.find_by(fight:)
        raise "There is non record of this gladiator #{the_looser.name} in this fight" unless the_looser_gladiator_fight

        the_looser_gladiator_fight.update!(battle_won: false)
      end
    end
  end
end