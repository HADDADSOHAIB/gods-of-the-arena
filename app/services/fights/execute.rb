# frozen_string_literal: true
module Fights
  class Execute
    attr_reader :fight, :error_message

    def initialize(fight:)
      @fight = fight
    end

    def call
      raise 'Fight already started' unless fight.status_planned?

      ActiveRecord::Base.transaction do
        fight.status_in_progress!
        execute_fight_steps
        fight.status_ended!
      end

      true
    rescue StandardError => error
      @error_message = error.message
      false
    end

    private

    def execute_fight_steps
      gladiators = fight.gladiators
      the_winner = ChooseWinner.new(gladiators: gladiators).call
      the_loosers = gladiators - [the_winner]
      Finalize.new(fight: fight, the_winner: the_winner, the_loosers: the_loosers).call
    end
  end
end
