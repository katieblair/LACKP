require 'sinatra'
require 'csv'
require 'pry'


def read_file(csv)
  players = []

  CSV.foreach(csv, headers: true) do |row|
    player = {
      name: row["first_name"] + ' ' + row["last_name"],
      position: row["position"],
      team_name: row["team"]
    }
    players << player
  end

  players
end

def find_team(team_name)
  teams = read_file('lackp_starting_rosters.csv')

  team_to_find = nil

  teams.each do |player|
    team = nil
    team_to_find = team if player[:team_name] == team_name
  end

  team_to_find
end

get '/teams' do
  @players = read_file('lackp_starting_rosters.csv')
    teams = []
    @players.each do |player|
      teams << player[:team_name]
    end
    @teams = teams.uniq
  erb :index
end

get '/teams/:team_name' do
  @players = read_file('lackp_starting_rosters.csv')
  @player = @players.find do |player|
    player[:team_name] == params[:team_name]

  end
  erb :team
end






