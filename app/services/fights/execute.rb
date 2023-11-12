module Fights
  class execute
    attr_reader :fight

    def initialize(fight:)
      @fight = fight
    end

    def call
      return unless fight.status_planned?
      
      ActiveRecord::Base.transaction do
        fight.status_in_progress!
        gladiators = fight.gladiators
        the_winner = ChooseWinner.new(gladiators:).call
        the_loosers = gladiators - the_winner
        Finalize.new(fight:, the_winner:, the_loosers:).call
        fight.status_ended!
      end

      true
    end
  end
end