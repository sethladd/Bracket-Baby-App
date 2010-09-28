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
    output << display_participant(match.participant1)
    output << display_participant(match.participant2)
    output << "</td>\n"
    not_visited_matches.delete(match)
    output << display_match(not_visited_matches.detect{|m| m.preceded_by?(match)}, not_visited_matches, round+1)
    output
  end
  
  def display_participant(participant)
    "<div>" +
    if participant
      participant.user.email
    else
      "TBD"
    end +
    "</div>\n"
  end
  
end