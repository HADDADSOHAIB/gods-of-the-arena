RSpec.describe Gladiators::FightStatistic, type: :service do
  let!(:gladiator){ create(:gladiator) }
  let!(:won_gladiator_fight){ create(:gladiator_fight, gladiator: gladiator, battle_won: true) }
  let!(:lost_gladiator_fight){ create(:gladiator_fight, gladiator: gladiator, battle_won: false) }
  let!(:planned_gladiator_fight){ create(:gladiator_fight, gladiator: gladiator, battle_won: nil) }

  subject { described_class.new(gladiator: gladiator) }

  describe '#number_of_fights' do
    it 'return number_of_fights' do
      expect(subject.number_of_fights).to eq(3)
    end
  end

  describe '#number_of_lost_fights' do
    it 'return number_of_lost_fights' do
      expect(subject.number_of_lost_fights).to eq(1)
    end
  end

  describe '#number_of_won_fights' do
    it 'return number_of_won_fights' do
      expect(subject.number_of_won_fights).to eq(1)
    end
  end

  describe '#number_of_planned_fights' do
    it 'return number_of_planned_fights' do
      expect(subject.number_of_planned_fights).to eq(1)
    end
  end

  describe '#winning_ratio' do
    it 'return winning_ratio' do
      expect(subject.winning_ratio).to eq(0.33)
    end
  end
end