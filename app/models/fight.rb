class Fight < ApplicationRecord
 #==== Attributes ====
 enum status: { planned: 0, in_progress: 1, ended: 2}, _prefix: true

  #==== Associations ====
  has_many :gladiator_fights, dependent: :nullify
  has_many :gladiators, through: :gladiator_fights

  has_many :won_gladiator_fights, ->{ won }, class_name: 'GladiatorFight', dependent: :nullify
  has_many :won_gladiators, through: :won_gladiator_fights, source: :gladiator

  has_many :lost_gladiator_fights, ->{ lost }, class_name: 'GladiatorFight', dependent: :nullify
  has_many :lost_gladiators, through: :lost_gladiator_fights, source: :gladiator

  #==== Instance methods ====
  def status_human
    I18n.t("fights.attributes.status.#{status}")
  end
end
