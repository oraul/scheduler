# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule do
  subject(:schedule) { create(:schedule) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
  end

  describe '#time_committed?' do
    subject(:time_commited?) { described_class.time_committed?(start_time, end_time) }

    context 'when it exists' do
      let(:start_time) { schedule.start_time }
      let(:end_time) { schedule.end_time }

      it { is_expected.to exist }
    end

    context 'when it not exists' do
      let(:start_time) { schedule.start_time - 1.day }
      let(:end_time) { schedule.end_time - 1.day }

      it { is_expected.not_to exist }
    end
  end
end
