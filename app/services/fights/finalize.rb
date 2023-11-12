# frozen_string_literal: true
module Fights
  class Finalize
    AFTER_FIGHT_STATUS = %w[recovering_from_fight dead].freeze
    GAINED_EXPERIENCE_POINTS = (1..10).to_a.freeze
    attr_reader :the_winner, :the_loosers, :fight

    def initialize(fight:, the_winner:, the_loosers:)
      @the_winner = the_winner
      @the_loosers = the_loosers
      @fight = fight
    end

    def call
      handle_winner(the_winner: the_winner)
      the_loosers.each do |the_looser|
        handle_looser(the_looser: the_looser)
      end
    end

    private

    def handle_winner(the_winner:)
      the_winner.update!(life_points: the_winner.life_points / 2,
                         experience_points: the_winner.experience_points + GAINED_EXPERIENCE_POINTS.sample)
      the_winner_gladiator_fight = the_winner.gladiator_fights.find_by(fight: fight)
      raise "There is non record of this gladiator #{the_winner.name} in this fight" unless the_winner_gladiator_fight

      the_winner_gladiator_fight.update!(battle_won: true)
    end

    def handle_looser(the_looser:)
      the_looser.update!(life_points: 0, health_status: AFTER_FIGHT_STATUS.sample)
      the_looser_gladiator_fight = the_looser.gladiator_fights.find_by(fight: fight)
      raise "There is non record of this gladiator #{the_looser.name} in this fight" unless the_looser_gladiator_fight

      the_looser_gladiator_fight.update!(battle_won: false)
    end
  end
end
