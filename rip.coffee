cheerio = require 'cheerio'
fs = require 'fs'
glob = require 'glob'


print_csv = (data) ->
  console.log "home_team,home_score,away_team,away_score,tournament"

  for row in data
    console.log "#{row.home},#{row.home_score},#{row.away},#{row.away_score},#{row.tournament}"

get_games = ($, file) ->

  games = []

  remove_seed = (str) ->
    result = /(.*)(\(\d+\))/.exec(str)
    if result?
      return result[1].trim()

  tourney = $('.breadcrumbs a:nth-of-type(2)').text()

  $('tr[data-game]').each (idx, el) ->
    game = {}

    elem = $(el)
    game.home = elem.find("span[data-type='game-team-home']").text().trim()
    game.away = elem.find("span[data-type='game-team-away']").text().trim()
    game.away_score = elem.find("span[data-type='game-score-away']").text().trim()
    game.home_score = elem.find("span[data-type='game-score-home']").text().trim()

    game.home = remove_seed game.home
    game.away = remove_seed game.away
    game.tournament = tourney

    if !game.home? || !game.away?
      console.warn "Found undefined team in pool play in #{file}"
    else
      games.push game


  $('div.bracket_game').each (idx, el) ->
    game = {}

    elem = $(el)
    game.home = elem.find("span[data-type='game-team-home']").text().trim()
    game.away = elem.find("span[data-type='game-team-away']").text().trim()
    game.away_score = elem.find("span[data-type='game-score-away']").text().trim()
    game.home_score = elem.find("span[data-type='game-score-home']").text().trim()

    game.home = remove_seed game.home
    game.away = remove_seed game.away
    game.tournament = tourney

    if !game.home? || !game.away?
      console.warn "Found undefined team in bracket play in  #{file}"
    else
      games.push game

  return games

games = []


glob 'data/index*', (er, files) ->
  for file in files
    $ = cheerio.load(fs.readFileSync(file))
    games = games.concat get_games($, file)

  print_csv(games)
