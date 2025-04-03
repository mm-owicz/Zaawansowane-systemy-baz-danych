db.counters.insertMany([
    { _id: "athletes_id", sequence_value: 11547 },
    { _id: "medals_id", sequence_value: 15316 },
    { _id: "games_id", sequence_value: 9 }
]);

function getNextSequence(sequenceName) {
    const counter = db.counters.findOneAndUpdate(
        { _id: sequenceName },
        { $inc: { sequence_value: 1 } },
        { returnDocument: "after" }
    );
    return counter.sequence_value;
};

///////////////////////////////

function validateGender(gender){
    const validGenders = ["Women", "Men"];
    if (!validGenders.includes(gender)) {
        throw new Error(`Invalid gender: ${gender}. Gender must be Women or Men.`);
    }
    return;
}

function validateYear(year){
    if (!Number.isInteger(year)) {
        throw new Error(`Invalid year: ${year}. Year must be an integer.`);
    }
    return;
}

function validateMedalType(medalType){
    const validMedalTypes = ["Gold", "Silver", "Bronze"];
    if (!validMedalTypes.includes(medalType)) {
        throw new Error(`Invalid medal type: ${medalType}. Medal type must be Gold, Silver or Bronze.`);
    }
    return;
}

function validateAthleteId(athleteId){
    if (!db.athletes.findOne({ _id: athleteId })) {
        throw new Error(`Did not find Athlete with ID ${athleteId}.`);
    }
    return;
}

function validateGameId(gameId){
    if (!db.games.findOne({ _id: gameId })) {
        throw new Error(`Did not find Olympic Game with ID ${gameId}.`);
    }
    return;
}

////////////////////////////////////

function addAthlete(name, gender, country, code) {
    validateGender(gender);
    const athleteId = getNextSequence("athletes_id");
    const athlete = {
        _id: athleteId,
        Athlete: name,
        Gender: gender,
        Team: { Country: country, Code: code }
    };
    db.athletes.insertOne(athlete);
    return athlete;
};

function addMedal(medalType, sport, event, athletesId, gameId) {
    validateMedalType(medalType);
    validateAthleteId(athletesId);
    validateGameId(gameId);
    const medalId = getNextSequence("medals_id");
    const medal = {
        _id: medalId,
        Medal: medalType,
        Sport_event: { Sport: sport, Event: event },
        athletes_id: athletesId,
        games_id: gameId
    };
    db.medals.insertOne(medal);
    return medal;
};

function addOlympicGame(year, city) {
    validateYear(year);
    const gameId = getNextSequence("games_id");
    const olympicGame = {
        _id: gameId,
        Year: year,
        City: city
    };
    db.games.insertOne(olympicGame);
    return olympicGame;
};

////////////////////////////

function updateAthleteName(athleteId, newName) {
    const result = db.athletes.updateOne(
        { _id: athleteId },
        { $set: { Athlete: newName } }
    );
    return result.modifiedCount > 0
        ? `Athlete name updated to ${newName}`
        : `No athlete found with ID ${athleteId}`;
}

function updateAthleteGender(athleteId, newGender) {
    validateGender(newGender);
    const result = db.athletes.updateOne(
        { _id: athleteId },
        { $set: { Gender: newGender } }
    );
    return result.modifiedCount > 0
        ? `Athlete gender updated to ${newGender}`
        : `No athlete found with ID ${athleteId}`;
}

function updateAthleteCountry(athleteId, newCountry) {
    const result = db.athletes.updateOne(
        { _id: athleteId },
        { $set: { "Team.Country": newCountry } }
    );
    return result.modifiedCount > 0
        ? `Athlete country updated to ${newCountry}`
        : `No athlete found with ID ${athleteId}`;
}

function updateAthleteCode(athleteId, newCode) {
    const result = db.athletes.updateOne(
        { _id: athleteId },
        { $set: { "Team.Code": newCode } }
    );
    return result.modifiedCount > 0
        ? `Athlete code updated to ${newCode}`
        : `No athlete found with ID ${athleteId}`;
}

function updateAthlete(athleteId, newName, newGender, newCountry, newCode) {
    validateGender(newGender);
    const result = db.athletes.updateOne(
        { _id: athleteId },
        { $set: {
            Athlete: newName,
            Gender: newGender,
            "Team.Country": newCountry,
            "Team.Code": newCode
        }}
    );
    return result.modifiedCount > 0
        ? `Athlete updated`
        : `No athlete found with ID ${athleteId}`;
}

function updateGameYear(gameId, newYear) {
    validateYear(year);
    const result = db.games.updateOne(
        { _id: gameId },
        { $set: { Year: newYear } }
    );
    return result.modifiedCount > 0
        ? `Olympic Game year updated to ${newYear}`
        : `No game found with ID ${gameId}`;
}

function updateGameCity(gameId, newCity) {
    const result = db.games.updateOne(
        { _id: gameId },
        { $set: { City: newCity } }
    );
    return result.modifiedCount > 0
        ? `Olympic Game city updated to ${newCity}`
        : `No game found with ID ${gameId}`;
}

function updateGame(gameId, newYear, newCity) {
    validateYear(year);
    const result = db.games.updateOne(
        { _id: gameId },
        { $set: {
            Year: newYear,
            City: newCity } }
    );
    return result.modifiedCount > 0
        ? `Olympic Game updated.`
        : `No game found with ID ${gameId}`;
}

function updateMedalType(medalId, newMedalType) {
    validateMedalType(medalType);
    const result = db.medals.updateOne(
        { _id: medalId },
        { $set: { Medal: newMedalType } }
    );
    return result.modifiedCount > 0
        ? `Medal type updated to ${newMedalType}`
        : `No medal found with ID ${medalId}`;
}

function updateMedalAthlete(medalId, newAthleteId) {
    validateAthleteId(newAthleteId);
    const result = db.medals.updateOne(
        { _id: medalId },
        { $set: { athletes_id: newAthleteId } }
    );
    return result.modifiedCount > 0
        ? `Medal athlete updated to ${newAthleteId}`
        : `No medal found with ID ${medalId}`;
}

function updateMedalGame(medalId, newGameId) {
    validateGameId(gameId);
    const result = db.medals.updateOne(
        { _id: medalId },
        { $set: { games_id: newGameId } }
    );
    return result.modifiedCount > 0
        ? `Medal game updated to ${newGameId}`
        : `No medal found with ID ${medalId}`;
}

function updateMedalSport(medalId, newSport) {
    const result = db.medals.updateOne(
        { _id: medalId },
        { $set: { "Sport_event.Sport": newSport} }
    );
    return result.modifiedCount > 0
        ? `Medal sport updated to ${newSport}`
        : `No medal found with ID ${medalId}`;
}

function updateMedalEvent(medalId, newEvent) {
    const result = db.medals.updateOne(
        { _id: medalId },
        { $set: {"Sport_event.Event": newEvent } }
    );
    return result.modifiedCount > 0
        ? `Medal event updated to ${newEvent}`
        : `No medal found with ID ${medalId}`;
}

function updateMedal(medalId, medalType, newSport, newEvent, newAthleteId, newGameId) {
    validateMedalType(medalType);
    validateAthleteId(newAthleteId);
    validateGameId(newGameId);
    const result = db.medals.updateOne(
        { _id: medalId },
        { $set: { Medal: newMedalType,
            "Sport_event.Sport": newSport,
            "Sport_event.Event": newEvent,
            athletes_id: newAthleteId,
            games_id: newGameId } }
    );
    return result.modifiedCount > 0
        ? `Medal updated.`
        : `No medal found with ID ${medalId}`;
}



