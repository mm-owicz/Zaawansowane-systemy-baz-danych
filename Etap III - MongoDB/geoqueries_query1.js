const { MongoClient } = require("mongodb");

async function findNearbyGames() {
  const client = new MongoClient("mongodb://localhost:27017");
  try {
    await client.connect();

    const db = client.db("olympic_medals");
    const games = db.collection("games");

    const nearbyGames = await games.find({
      location: {
        $near: {
          $geometry: { type: "Point", coordinates: [21.017532, 52.237049] },
          $maxDistance: 1200000
        }
      }
    }).toArray();

    console.log("Nearby Games:", nearbyGames);
  } finally {
    await client.close();
  }
}

findNearbyGames().catch(console.error);
