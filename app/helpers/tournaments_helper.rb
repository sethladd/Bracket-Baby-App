module TournamentsHelper
  
  def display_bracket(bracket)
    not_visited_matches = bracket.matches.dup
    output = ''
    
    bracket.matches.select{|m| m.round == 0}.each do |first_round_match|
      output << "<tr>\n"
      output << display_match(first_round_match, not_visited_matches, 0)
      output << "</tr>\n"
    end
    
    output.html_safe
  end
  
  def display_match(match, not_visited_matches, round)
    return '' unless match
    output = render('bracket_box', :match => match, :round => round, :players => match.match_players.sort_by{|mp| mp.id})
    not_visited_matches.delete(match)
    output << display_match(not_visited_matches.detect{|m| m.preceded_by?(match)}, not_visited_matches, round+1)
    output
  end
  
end