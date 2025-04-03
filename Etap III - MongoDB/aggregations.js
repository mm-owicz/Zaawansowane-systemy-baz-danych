function getMedalsByAthlete() {
    return db.medals.aggregate([
        {
            $lookup: {
                from: "athletes",
                localField: "athletes_id",
                foreignField: "_id",
                as: "athlete_info"
            }
        },
        { $unwind: "$athlete_info" },
        {
            $group: {
                _id: "$athletes_id",
                athlete_name: { $first: "$athlete_info.Athlete" },
                gender: { $first: "$athlete_info.Gender" },
                medals_count: { $sum: 1 }
            }
        },
        { $sort: { medals_count: -1 } }
    ]);
}


function getMedalsByCountryTotal() {
    return db.medals.aggregate([
        {
            $lookup: {
                from: "athletes",
                localField: "athletes_id",
                foreignField: "_id",
                as: "athlete_info"
            }
        },
        { $unwind: "$athlete_info" },
        {
            $group: {
                _id: "$athlete_info.Team.Country",
                total_medals: { $sum: 1 }
            }
        },
        { $sort: { total_medals: -1 } }
    ]);
}


function getAthleteMedalsAndSports(){
    return db.medals.aggregate([
        {
            $lookup: {
                from: "athletes",
                localField: "athletes_id",
                foreignField: "_id",
                as: "player_info"
            }
        },
        { $unwind: "$player_info" },
        {
            $group: {
                _id: "$athletes_id",
                athlete_name: { $first: "$player_info.Athlete" },
                gender: { $first: "$player_info.Gender" },
                total_medals: { $sum: 1 },
                sports_events: {
                    $addToSet: "$Sport_event"
                }
            }
        },
        { $sort: { total_medals: -1 } }
    ]);

}

