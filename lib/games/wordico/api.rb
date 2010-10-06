require 'httparty'

module Games
  module Wordico
    class Api
      include HTTParty
      base_uri 'http://play.wordico.com/api/v1'
      
      def game_state(game_uuid)
        self.class.get('/games/' + game_uuid)
      end
      
      def create_game(users, rack_size = 8, time_limit = 24, board_name = nil)
        board_name ||= ['Vortex', 'Swirl', 'Zig Zag', 'Crisscross', 'Letter Bomb'].sort_by{rand}.first
        create_game = {
          :boardName => board_name,
          :rackSize => rack_size,
          :timeLimit => time_limit,
          :players => users.map{|u| {:openId => u.identifier_url, :email => u.email}}
        }
        puts create_game.to_json
        response = self.class.post('/games', :body => create_game.to_json)
      end
      
      def delete_game(game_uuid)
        self.class.delete('/games/' + game_uuid)
      end
    end
  end
end