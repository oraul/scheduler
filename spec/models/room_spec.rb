# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room do
  subject(:room) { build(:room) }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end
end
