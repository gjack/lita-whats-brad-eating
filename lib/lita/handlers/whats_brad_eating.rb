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
        response.reply 'Actual results coming soon!'
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

      Lita.register_handler(self)
    end
  end
end
