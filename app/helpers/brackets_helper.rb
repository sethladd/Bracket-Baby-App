module BracketsHelper
  def display_table_bracket(bracket)
    not_visited_matches = bracket.matches.dup
    output = ''
    
    bracket.first_round_matches.each do |first_round_match|
      output << "<tr>\n"
      output << display_table_match(first_round_match, not_visited_matches)
      output << "</tr>\n"
    end
    
    output.html_safe
  end
  
  def display_table_match(match, not_visited_matches, round = 0, previous_match = nil)
    return '' unless match
    players = match.match_players.sort_by{|mp| mp.id}
    
    # so this match lists its players in order from previous matches
    if previous_match && previous_match.is_user_playing?(players.last.user)
      players.reverse!
    end
    
    output = render('bracket_box_table',
                :match => match,
                :round => round,
                :players => players)
    not_visited_matches.delete(match)
    next_match = not_visited_matches.detect{|m| m.preceded_by?(match)}
    output << display_table_match(next_match, not_visited_matches, round+1)
    output
  end
end