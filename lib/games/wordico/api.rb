require 'httparty'

module Games
  module Wordico
    class Api
      include HTTParty
      base_uri 'http://play.wordico.com/api/v1'
      
      def game_state(game_uuid)
        game_uuid = extract_uuid(game_uuid)
        self.class.get('/games/' + game_uuid)
      end
      
      def create_game(users, rack_size = 8, time_limit_in_seconds = 24.hours, board_name = nil)
        board_name ||= ['Vortex', 'Swirl', 'Zig Zag', 'Crisscross', 'Letter Bomb'].sort_by{rand}.first
        create_game = {
          :boardName => board_name,
          :rackSize => rack_size,
          :timeLimitSeconds => time_limit_in_seconds,
          :players => users.map{|u| {:email => u.email}}
        }
        response = self.class.post('/games', :body => create_game.to_json)
        response.headers['Location']
      end
      
      def delete_game(game_uuid)
        game_uuid = extract_uuid(game_uuid)
        self.class.delete('/games/' + game_uuid)
      end
      
      private
      
      def extract_uuid(uuid_or_uri)
        uuid_or_uri.split('/').last if uuid_or_uri =~ /^http/
      end
    end
  end
end