db.athletes.createIndex({ "Team.Country": 1 });
db.athletes.createIndex({ "Gender": 1 });

db.olympics_games.createIndex({ "Year": 1 });

db.medals.createIndex({ "athletes_id": 1 });
db.medals.createIndex({ "games_id": 1 });
db.medals.createIndex({ "Sport_event.Sport": 1, "Sport_event.Event": 1 });
