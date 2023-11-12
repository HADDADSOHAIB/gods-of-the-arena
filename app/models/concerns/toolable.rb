# frozen_string_literal: true
module Toolable
  extend ActiveSupport::Concern

  included do
    has_one :tool, as: :toolable, touch: true, dependent: :nullify
  end
end
