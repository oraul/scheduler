# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrentAuthEntity do
  subject(:entity) { build(:current_auth_entity) }

  it { is_expected.to have_attributes(sub: 'dbdc2419-f6cf-49c8-a545-a908a03741ce') }
  it { is_expected.to have_attributes(name: 'John Doe') }
  it { is_expected.to have_attributes(exp: entity.exp) }
  it { is_expected.to have_attributes(iss: 'auth') }
  it { is_expected.to have_attributes(aud: 'scheduler') }
end
