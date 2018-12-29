module Lita
  module Handlers
    class WhatsBradEating < Handler
      # insert handler code here
      route /^what's brad eating$/i,
      :brad_eats,
      command: true,
      help: {
        "what's brad eating" => "latest post from brad's food tumblr"
      }

      def brad_eats(response)
        response.reply 'Actual results coming soon!'
      end

      Lita.register_handler(self)
    end
  end
end
