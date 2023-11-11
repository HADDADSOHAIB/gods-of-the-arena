class GladiatorFight < ApplicationRecord

  #==== Associations ====
  belongs_to :gladiator
  belongs_to :fight

  #==== Scopes ====
  scope :won, ->{where(battle_won: true)}
  scope :lost, ->{where(battle_won: false)}
end
