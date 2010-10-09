require 'games/wordico/api'

module Games
  module Wordico
    class Flow
      
      def initialize
        @api = Games::Wordico::Api.new
      end
      
      def hourly
        Tournament.transaction do
          # start any tournaments
          Tournament.should_start.each do |tournament|
            tournament.start!
          end
        
          # update all in progress matches
          Match.in_progress.each do |match|
            game_state = @api.game_state(match.external_game_uri)
            match.update_game_state!(game_state)
          end
        
          # start any new matches
          Match.should_start.each do |match|
            users = match.match_players.map{|mp| mp.user}
            external_game_uri = @api.create_game(users)
            match.start!(external_game_uri)
          end
        end
      end
    end
  end
end