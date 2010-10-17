require 'games/wordico/api'

module Games
  module Wordico
    class Flow
      
      RACK_SIZE = 8
      
      def initialize
        @api = Games::Wordico::Api.new
      end
      
      def hourly
        Tournament.transaction do
          Rails.logger.info('Starting any pending tournaments')
          Tournament.should_start.each do |tournament|
            tournament.start!
          end
        
          Rails.logger.info('Updating any in-progress matches')
          Match.in_progress.each do |match|
            Rails.logger.debug('Getting game state for match ' + match.external_game_uri)
            game_state = @api.game_state(match.external_game_uri)
            match.update_game_state!(game_state)
          end
        
          Rails.logger.info('Creating any new matches')
          Match.should_start.each do |match|
            users = match.match_players.map{|mp| mp.user}
            external_game_uri = @api.create_game(users, RACK_SIZE, match.match_length_seconds)
            match.start!(external_game_uri)
          end
          
          Rails.logger.info('Finishing any tournaments')
          Tournament.in_progress.select do |tournament|
            tournament.finished?
          end.each do |tournament|
            tournament.end!
          end
        end
      end
    end
  end
end