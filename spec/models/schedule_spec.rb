# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule do
  subject(:schedule) { create(:schedule) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:started_at) }
    it { is_expected.to validate_presence_of(:ended_at) }
  end

  describe '#time_committed?' do
    subject(:time_commited?) { described_class.time_committed?(started_at, ended_at) }

    context 'when it exists' do
      let(:started_at) { schedule.started_at }
      let(:ended_at) { schedule.ended_at }

      it { is_expected.to exist }
    end

    context 'when it not exists' do
      let(:started_at) { schedule.started_at - 1.day }
      let(:ended_at) { schedule.ended_at - 1.day }

      it { is_expected.not_to exist }
    end
  end
end
