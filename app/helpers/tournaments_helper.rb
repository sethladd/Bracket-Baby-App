module TournamentsHelper

  def display_svg_bracket(bracket)
    not_visited_matches = bracket.matches.dup
    output = ''
    match_iter = 0
    
    bracket.matches.select{|m| m.round == 0}.each do |first_round_match|
      output << display_svg_match(first_round_match, not_visited_matches, 0,  match_iter)
      match_iter = match_iter+1
    end
    
    output.html_safe
  end
  
  def display_svg_match(match, not_visited_matches, round, match_iter)
    return '' unless match
    
    output = render('bracket_box', :match => match, :round => round, :players => match.match_players.sort_by{|mp| mp.id}, :match_iter => match_iter)
    not_visited_matches.delete(match)
    output << display_svg_match(not_visited_matches.detect{|m| m.preceded_by?(match)}, not_visited_matches, round+1, match_iter)
    output.html_safe
  end  
  
end