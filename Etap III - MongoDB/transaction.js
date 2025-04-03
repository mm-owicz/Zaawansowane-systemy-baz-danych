const { MongoClient } = require('mongodb');

async function main(){
    const client = new MongoClient("mongodb://localhost:27017");

    try {
        await client.connect();

        await performTransaction(client);

    } finally {
        await client.close();
    }
}

async function performTransaction(client){
    const medals = client.db('olympic_medals').collection('medals');
    const session = client.startSession();

    const transactionOptions = {
            readPreference: 'primary',
            readConcern: { level: 'local' },
            writeConcern: { w: 'majority' }
        };

    try {
        await session.withTransaction(async () => {
            const res = await medals.updateOne(
                { _id: 3 },
                {
                    $set: {
                        "Sport_event.Sport": "Swimming",
                        "Sport_event.Event": "200m Butterfly"
                    }
                },
                { session }
            );
            console.log(`Result of transaction: ${res.modifiedCount}`)
            const updatedMedal = await medals.findOne({ "Sport_event.Sport": "Swimming"}, {session} );
            console.log("Edited medal ID: " + updatedMedal._id)
            if (!updatedMedal) {
                throw new Error("Medal not found.");
            }

            session.commitTransaction();
            console.log("Transaction successful");

        }, transactionOptions);


    } catch (error) {
        console.log("Transaction error:", error);
        await session.abortTransaction();

    } finally {
        await session.endSession();
    }
}



main().catch(console.error);
