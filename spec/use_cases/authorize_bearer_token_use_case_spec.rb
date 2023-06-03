# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeBearerTokenUseCase do
  include AuthMock

  subject(:use_case) { described_class }

  describe '.call' do
    subject(:call) { use_case.call(bearer_token) }

    context 'with valid bearer token' do
      let(:exp) { 24.hours.from_now.to_i }

      let(:bearer_token) { bearer_token_mock(exp:) }

      it { is_expected.to be_a(CurrentAuthEntity) }

      it { is_expected.to have_attributes(sub: 'dbdc2419-f6cf-49c8-a545-a908a03741ce') }

      it { is_expected.to have_attributes(name: 'John Doe') }

      it { is_expected.to have_attributes(exp:) }

      it { is_expected.to have_attributes(iss: 'auth') }

      it { is_expected.to have_attributes(aud: 'scheduler') }
    end

    context 'without value' do
      let(:bearer_token) { nil }

      it { expect { call }.to raise_error(JWT::DecodeError) }
    end
  end
end
