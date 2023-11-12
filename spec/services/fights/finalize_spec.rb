RSpec.describe Fights::Finalize, type: :service do
  let!(:the_winner){ create(:gladiator, life_points: 100, experience_points: 40) }
  let!(:the_looser){ create(:gladiator) }
  let!(:fight){ create(:fight) }
  let!(:the_winner_gladiator_fight){ create(:gladiator_fight, gladiator: the_winner, fight: fight, battle_won: nil) }
  let!(:the_looser_gladiator_fight){ create(:gladiator_fight, gladiator: the_looser, fight: fight, battle_won: nil) }

  subject(:service) { described_class.new(fight: fight, the_winner: the_winner, the_loosers: [the_looser]) }

  describe '#call' do
    it 'Set the_winner_gladiator_fight battle won to true' do
      subject.call
      expect(the_winner_gladiator_fight.reload.battle_won).to eq true
    end

    it 'Devide the life point of the winner by 2' do
      subject.call
      expect(the_winner.reload.life_points).to eq 50
    end

    it 'Give the winners some experience points' do
      subject.call
      expect(the_winner.reload.experience_points).to be > 40
    end

    it 'Set the_looser_gladiator_fight battle won to true' do
      subject.call
      expect(the_looser_gladiator_fight.reload.battle_won).to eq false
    end

    it 'Set the_looser life points to 0' do
      subject.call
      expect(the_looser.reload.life_points).to eq 0
    end

    it 'Remove the_looser health status from ready to fight' do
      subject.call
      expect(the_looser.reload.health_status).not_to eq('ready_for_fight')
    end
  end
end
