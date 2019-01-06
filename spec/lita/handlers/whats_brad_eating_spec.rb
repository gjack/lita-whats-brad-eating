require "spec_helper"

describe Lita::Handlers::WhatsBradEating, lita_handler: true do
  describe 'routes' do
    it { is_expected.to route("Lita what's brad eating") }
    it { is_expected.to route("Lita what's BRAD eating") }
  end

  describe 'response' do
    let(:body) { subject.response.body }

    it "should be able to pull down some HTML from Brad's blog" do
      expect(body =~ /<html>/i).to be_truthy
    end

    it 'should include something that looks like an image tag' do
      expect(body =~ /img src/i).to be_truthy
    end

    it 'should include a caption' do
      expect(body.include?('caption')).to be_truthy
    end
  end

  describe ':parsed_response' do
    it 'should return a nokogiri object with a :css method we can search on' do
      expect(subject.parsed_response).to respond_to(:css)

      images = subject.parsed_response.css('img')
      expect(images.any?).to be_truthy
    end
  end

  describe ':first_post' do
    it 'finds exactly one node' do
      expect(subject.first_post.count).to eq(1)
    end
  end

  describe ':image' do
    it 'finds at least one node' do
      attributes = subject.image.attributes
      expect(attributes.fetch('src').value).to include('https')
      expect(attributes.key?('alt')).to be_truthy
    end
  end

  describe ':brad_eats' do
    it 'responds with a caption and an image url' do
      send_message "Lita what's brad eating"
      expect(replies.last).to match(/\w+ >> https/i)
    end
  end
end
