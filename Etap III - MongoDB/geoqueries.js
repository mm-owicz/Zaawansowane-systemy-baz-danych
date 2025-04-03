// Geo quries (zapytania geoprzestrzenne)

// dodanie lokacji:
db.games.updateOne(
    { City: "Montreal" },
    { $set: { location: { type: "Point", coordinates: [-73.561668, 45.508888] } } }  // long, lat
);

db.games.updateOne(
    { City: "Moscow" },
    { $set: { location: { type: "Point", coordinates: [37.618423, 55.751244] } } }
);

db.games.updateOne(
    { City: "Los Angeles" },
    { $set: { location: { type: "Point", coordinates: [-118.243683, 34.052235] } } }
);

db.games.updateOne(
    { City: "Seoul" },
    { $set: { location: { type: "Point", coordinates: [127.024612, 37.532600] } } }
);

db.games.updateOne(
    { City: "Barcelona" },
    { $set: { location: { type: "Point", coordinates: [2.154007, 41.390205] } } }
);

db.games.updateOne(
    { City: "Atlanta" },
    { $set: { location: { type: "Point", coordinates: [-84.386330, 33.753746] } } }
);

db.games.updateOne(
    { City: "Sydney" },
    { $set: { location: { type: "Point", coordinates: [151.209900, -33.865143] } } }
);

db.games.updateOne(
    { City: "Athens" },
    { $set: { location: { type: "Point", coordinates: [23.727539, 37.983810] } } }
);

db.games.updateOne(
    { City: "Beijing" },
    { $set: { location: { type: "Point", coordinates: [116.383331, 39.916668] } } }
);

// Indeks
db.games.createIndex({ location: "2dsphere" });

