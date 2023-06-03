# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthAdapter do
  subject(:adapter) { described_class }

  describe '.encode' do
    subject(:encode) { adapter.encode('token') }

    it { is_expected.to be_a(String) }

    it { expect(encode.split('.').size).to eq 3 }
  end

  describe '.decode' do
    subject(:decode) { adapter.decode(token) }

    context 'when is valid token' do
      let(:token) { adapter.encode({ foo: 'bar' }) }

      it { is_expected.to eq('foo' => 'bar') }
    end

    context 'when is invalid token' do
      let(:token) { 'invalid_token' }

      it { expect { decode }.to raise_error(JWT::DecodeError) }
    end
  end
end
