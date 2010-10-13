module TournamentsHelper

  def display_svg_bracket(bracket)
    not_visited_matches = bracket.matches.dup
    output = ''
    is_first_match = true
    first_match_id = ''
    
    bracket.matches.select{|m| m.round == 0}.each do |first_round_match|
      if (is_first_match)
        first_match_id = first_round_match.id
        is_first_match = false
      end
      output << display_svg_match(first_round_match, not_visited_matches, 0, first_match_id)
    end
    
    output.html_safe
  end
  
  def display_svg_match(match, not_visited_matches, round, starting_match_id)
    return '' unless match
    
    output = render('bracket_box', :match => match, :round => round, :players => match.match_players.sort_by{|mp| mp.id}, :starting_match => starting_match_id)
    not_visited_matches.delete(match)
    output << display_svg_match(not_visited_matches.detect{|m| m.preceded_by?(match)}, not_visited_matches, round+1, starting_match_id)
    output.html_safe
  end  
  
end