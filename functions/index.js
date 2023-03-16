const functions = require("firebase-functions");


const admin = require("firebase-admin");


admin.initializeApp(functions.config().firebase);


// const msgData;


exports.offerTrigger = functions.firestore.document(
    "offers/{offerId}"
).onCreate((snapshot, context)=>{
  const msgData = snapshot.data();

  admin.firestore().collection("tokens").get().then((snapshots)=>{
    const tokens = [];
    if (snapshots.empty) {
      console.log("No Devices Found");
    } else {
      for (const pushTokens of snapshots.docs) {
        tokens.push(pushTokens.data().token);
      }
      const topicName = "indore";
      const payload ={
        "notification": {
          "title": "From " + msgData.businessType,
          "body": "Offer is : " + msgData.offer,
          // "image": "https://as2.ftcdn.net/v2/jpg/02/48/63/27/1000_F_248632756_DEHjgLVeIyPJH0odKhkIsDHjUfx9MzFQ.jpg",
          "sound": "default",
        },
        "android": {
          notification: {
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/d/dd/Goldene_Kuppeln_1000x1000_400KB.jpg",
            icon: "shopobid.png",
            color: "#7e55c3",
          },
        },
        "topic": topicName,
        "data": {
          "name": msgData.name,
          "email": msgData.email,
          "phone": msgData.phone,
          "image": "https://as2.ftcdn.net/v2/jpg/02/48/63/27/1000_F_248632756_DEHjgLVeIyPJH0odKhkIsDHjUfx9MzFQ.jpg",
        },
      };

      return admin.messaging().sendToDevice(tokens, payload).then((response)=>{
        console.log("pushed them all");
      }).catch((err) => {
        console.log(err);
      });
    }
  });
});
