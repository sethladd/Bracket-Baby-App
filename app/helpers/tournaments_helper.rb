module TournamentsHelper

  def display_svg_bracket(bracket)
    not_visited_matches = bracket.matches.dup
    output = ''
    
    bracket.first_round_matches.each_with_index do |first_round_match, match_iter|
      output << display_svg_match(first_round_match, not_visited_matches, 0, match_iter, first_round_match)
    end
    
    output.html_safe
  end
  
  def display_svg_match(match, not_visited_matches, round, match_iter, preceding_match)
    return '' unless match
    
    players = match.match_players.sort_by{|mp| mp.id}
    if (preceding_match != match && !preceding_match.winner.nil? &&
        (preceding_match.is_user_playing?(players.last.user)))
      players.reverse!
    end
    
    output = render('bracket_box_svg',
                      :match => match,
                      :round => round,
                      :players => players,
                      :match_iter => match_iter)
    not_visited_matches.delete(match)
    next_match = not_visited_matches.detect{|m| m.preceded_by?(match)}
    output << display_svg_match(next_match, not_visited_matches, round+1, match_iter, match)
    output.html_safe
  end
  
end