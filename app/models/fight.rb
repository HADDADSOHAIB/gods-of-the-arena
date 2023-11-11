class Fight < ApplicationRecord

  #==== Associations ====
  has_many :gladiator_fights, dependent: :nullify
  has_many :gladiators, through: :gladiator_fights

  has_many :won_gladiator_fights, ->{ won }, class_name: 'GladiatorFight', dependent: :nullify
  has_many :won_gladiators, through: :won_gladiator_gladiators, source: :gladiator

  has_many :lost_gladiator_fights, ->{ lost }, class_name: 'GladiatorFight', dependent: :nullify
  has_many :lost_gladiators, through: :lost_gladiator_gladiators, source: :gladiator
end
