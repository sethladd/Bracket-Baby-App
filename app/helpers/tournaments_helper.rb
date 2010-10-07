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
    output = "<td"
    (output << " rowspan=\"#{2**round}\"") if round > 0
    output << ">\n"
    emails = match.match_players.map{|mp| mp.user.email}.sort
    output << display_participant(emails.first)
    output << display_participant(emails.last)
    output << "</td>\n"
    not_visited_matches.delete(match)
    output << display_match(not_visited_matches.detect{|m| m.preceded_by?(match)}, not_visited_matches, round+1)
    output
  end
  
  def display_participant(email)
    "<div>" + h(email || 'TBD') + "</div>\n"
  end
  
end