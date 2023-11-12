# frozen_string_literal: true
class ToolGladiatorFight < ApplicationRecord
  belongs_to :tool
  belongs_to :gladiator
  belongs_to :fight
end
