const { MongoClient } = require("mongodb");

async function findGamesInBoundary() {
  const client = new MongoClient("mongodb://localhost:27017");
  try {
    await client.connect();

    const db = client.db("olympic_medals");
    const games = db.collection("games");

    const gamesInBoundary = await games.find({
      location: {
        $geoWithin: {
          $box: [
            [-10.0, 35.0], // South-West
            [30.0, 70.0]   // North-East
          ]
        }
      }
    }).toArray();

    console.log("Games within boundaries:", gamesInBoundary);
  } finally {
    await client.close();
  }
}

findGamesInBoundary().catch(console.error);
