require 'games/wordico/api'

module Games
  module Wordico
    class Flow
      
      def initialize
        @api = Games::Wordico::Api.new
      end
      
      def hourly
        # update all in progress matches
        Match.in_progress.each do |match|
          game_state = api.game_state(match.external_game_uri)
          match.update_game_state!(game_state)
        end
        
        # start any new matches
        
      end
    end
  end
end