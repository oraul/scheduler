# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room do
  subject(:room) { build(:room) }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:opened_at) }
    it { is_expected.to validate_presence_of(:closed_at) }

    context 'when start time is 08:00:00 and end time is 09:00:00' do
      it { is_expected.to allow_value('08:59:59').for(:opened_at) }
      it { is_expected.not_to allow_value('09:00:00').for(:opened_at) }
      it { is_expected.to allow_value('08:00:01').for(:closed_at) }
      it { is_expected.not_to allow_value('08:00:00').for(:closed_at) }
    end
  end
end
