# frozen_string_literal: true
RSpec.describe Fights::Execute, type: :service do
  subject(:service) { described_class.new(fight: fight) }

  let!(:first_gladiator) { create(:gladiator) }
  let!(:second_gladiator) { create(:gladiator) }
  let!(:fight) { create(:fight) }
  let!(:the_winner_gladiator_fight) do
    create(:gladiator_fight, gladiator: first_gladiator, fight: fight, battle_won: nil)
  end
  let!(:the_looser_gladiator_fight) do
    create(:gladiator_fight, gladiator: second_gladiator, fight: fight, battle_won: nil)
  end

  describe '#call' do
    it 'call ChooseWinner service' do
      expect_any_instance_of(Fights::ChooseWinner).to receive(:call) # rubocop:disable RSpec/AnyInstance
      service.call
    end

    it 'call Finalize service' do
      expect_any_instance_of(Fights::Finalize).to receive(:call) # rubocop:disable RSpec/AnyInstance
      service.call
    end

    it 'change fight status to ended' do
      service.call
      expect(fight.status).to eq('ended')
    end
  end
end
