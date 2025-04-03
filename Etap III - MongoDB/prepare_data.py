import pandas as pd

input_file = "olympics_dataset.csv"
players_output_file = "athletes.csv"
medals_output_file = "medals.csv"
games_output_file = "games.csv"

raw_data = pd.read_csv(input_file)

raw_data = raw_data.dropna(subset=['Gender'])

unique_players = raw_data[['Athlete', 'Gender']].drop_duplicates()
unique_players['athletes_id'] = range(1, len(unique_players) + 1)
player_id_mapping = dict(zip(
    unique_players[['Athlete', 'Gender']].apply(tuple, axis=1),
    unique_players['athletes_id']
))
raw_data['athletes_id'] = raw_data[['Athlete', 'Gender']].apply(tuple, axis=1).map(player_id_mapping)


players_df = raw_data[['Athlete', 'Gender', 'Country', 'Country_Code']].drop_duplicates()
players_df['athletes_id'] = range(1, len(players_df) + 1)
players_df['Team'] = players_df.apply(
    lambda row: {"Country": row['Country'], "Code": row['Country_Code']}, axis=1
)
players_df = players_df[['athletes_id', 'Athlete', 'Gender', 'Team']]


olympics_games_df = raw_data[['Year', 'City']].drop_duplicates()
olympics_games_df['games_id'] = range(1, len(olympics_games_df) + 1)
olympics_games_df = olympics_games_df[['games_id', 'Year', 'City']]

medals_df = raw_data.merge(olympics_games_df, on=['Year', 'City'])
medals_df = medals_df[['Medal', 'Sport', 'Event', 'athletes_id', 'games_id']]
medals_df['Sport_event'] = medals_df.apply(
    lambda row: {"Sport": row['Sport'], "Event": row['Event']}, axis=1
)
medals_df['medals_id'] = range(1, len(medals_df) + 1)
medals_df = medals_df[['medals_id', 'Medal', 'Sport_event', 'athletes_id', 'games_id']]


players_df = players_df.rename(columns={'athletes_id': '_id'})
medals_df = medals_df.rename(columns={'medals_id': '_id'})
olympics_games_df = olympics_games_df.rename(columns={'games_id': '_id'})


players_json = players_df.to_json(orient='records', indent=4)
with open('players.json', 'w') as f:
    f.write(players_json)

olympics_games_json = olympics_games_df.to_json(orient='records', indent=4)
with open('games.json', 'w') as f:
    f.write(olympics_games_json)

medals_json = medals_df.to_json(orient='records', indent=4)
with open('medals.json', 'w') as f:
    f.write(medals_json)
