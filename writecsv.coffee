data = require './data.json'

console.log "home_team,home_score,away_team,away_score"

for row in data.results.collection1
  console.log "#{row.home_team.text},#{row.home_score},#{row.away_team.text},#{row.away_score}"
