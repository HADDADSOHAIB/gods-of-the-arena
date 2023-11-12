class GladiatorFight < ApplicationRecord

  #==== Associations ====
  belongs_to :gladiator
  belongs_to :fight

  #==== Scopes ====
  scope :won, ->{where(battle_won: true)}
  scope :lost, ->{where(battle_won: false)}
  scope :planned, ->{where(battle_won: nil)}

  #==== Validations ====
  validates :gladiator_id, uniqueness: { scope: :fight_id }
  
end
