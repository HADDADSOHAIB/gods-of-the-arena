class Gladiator < ApplicationRecord

  #==== Attributes ====
  enum health_status: { ready_for_fight: 0, recovering_from_fight: 1, dead: 2}, _prefix: true

  has_one_attached :avatar

  #==== Validations ====
  validates :name, :life_points, :attack_points, :magic_points, :health_status, :age, :experience_points, presence: :true
  validates :life_points, :attack_points, :magic_points, inclusion: { in: (0..100), message: 'should be between 0 and 100' }
  validates :age, :experience_points, inclusion: { in: (0...), message: 'should be greater than 0' }

  #==== Associations ====
  has_many :gladiator_fights, dependent: :nullify
  has_many :fights, through: :gladiator_fights

  has_many :won_gladiator_fights, ->{ won }, class_name: 'GladiatorFight', dependent: :nullify
  has_many :won_fights, through: :won_gladiator_fights, source: :fight

  has_many :lost_gladiator_fights, ->{ lost }, class_name: 'GladiatorFight', dependent: :nullify
  has_many :lost_fights, through: :lost_gladiator_fights, source: :fight

  #==== Scopes ====
  scope :has_life_points, ->{ where.not(life_points: 0) }

  #==== Instance methods ====
  def health_status_human
    I18n.t("gladiators.attributes.health_status.#{health_status}")
  end

  def avatar_path_wrapper
    avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_path(avatar) : 'default-gladiator.jpeg'
  end

  #==== Class methods ====

  def self.health_status_human_wrapper
    health_statuses.map{|(k, _)|[I18n.t("gladiators.attributes.health_status.#{k}"), k]}
  end
end
