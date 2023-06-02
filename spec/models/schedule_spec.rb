# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule do
  subject(:schedule) { build(:schedule) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
  end
end
