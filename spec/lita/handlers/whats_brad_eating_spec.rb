require "spec_helper"

describe Lita::Handlers::WhatsBradEating, lita_handler: true do
  describe 'routes' do
    it { is_expected.to route("Lita what's brad eating") }
    it { is_expected.to route("Lita what's BRAD eating") }
  end
end
