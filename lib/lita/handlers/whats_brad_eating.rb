require 'nokogiri'

module Lita
  module Handlers
    class WhatsBradEating < Handler
      # insert handler code here
      BLOG_URL = 'https://whatsbradeating.tumblr.com'.freeze

      route /^what's brad eating$/i,
      :brad_eats,
      command: true,
      help: {
        "what's brad eating" => "latest post from brad's food tumblr"
      }

      def brad_eats(response)
        caption_text = caption.gsub(/\n.*/, '')
        image_url = image.get_attribute('src')
        msg = "#{caption_text} >> #{image_url}"
        response.reply msg
      end

      def response
        @_response ||= http.get(BLOG_URL)
      end

      def parsed_response
        Nokogiri.parse(response.body)
      end

      def first_post
        parsed_response.css('section.post').first
      end

      def image
        first_post.css('.photo-wrapper img').first
      end

      def caption
        image.get_attribute('alt')
      end

      Lita.register_handler(self)
    end
  end
end
