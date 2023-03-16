//importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
//importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");
import { getMessaging } from "firebase/messaging";
import { onBackgroundMessage } from "firebase/messaging/sw";
//import { getMessaging, getToken, onMessage } from "firebase/messaging";

const firebaseConfig = {
    apiKey: "AIzaSyDhBplEotbyUCro_lzTWR3PYJt15cF4U_Y",
    authDomain: "findsonaweb.firebaseapp.com",
    projectId: "findsonaweb",
    storageBucket: "findsonaweb.appspot.com",
    messagingSenderId: "688494126520",
    appId: "1:688494126520:web:a475410f690796aff5db4d",
    measurementId: "G-59S4PD1Q78"
  };

firebase.initializeApp(firebaseConfig);

// const messaging = getMessaging(fapp);

// getToken(messaging, {
//   vapidKey:
//     "BOA9JOc1l6Mkei4I_I03qze_PKVCGhbB54xCdxiAH_PweArUdG-P9DSyxpm19-eRONw-T7HwCFk21Za1sFuGH2o",
// })
//   .then((currentToken) => {
//     if (currentToken) {
//       console.log("Firebase Token", currentToken);
//     } else {
//       // Show permission request UI
//       console.log(
//         "No registration token available. Request permission to generate one."
//       );
//       // ...
//     }
//   })
//   .catch((err) => {
//     console.log("An error occurred while retrieving token. ", err);
//     // ...
//   });
//   onMessage(messaging, (payload) => {
//     console.log("Message received. ", payload);
//     // ...
//   });
  
  
// messaging.setBackgroundMessageHandler(function (payload) {
//     const promiseChain = clients
//         .matchAll({
//             type: "window",
//             includeUncontrolled: true
//         })
//         .then(windowClients => {
//             for (let i = 0; i < windowClients.length; i++) {
//                 const windowClient = windowClients[i];
//                 windowClient.postMessage(payload);
//             }
//         })
//         .then(() => {
//             return registration.showNotification("New Message");
//         });
//     return promiseChain;
// });
// self.addEventListener('notificationclick', function (event) {
//     console.log('notification received: ', event)
// });

// const messaging = getMessaging();
// onMessage(messaging, (payload) => {
//   console.log('Message received. ', payload);
//   // ...
// });
// onBackgroundMessage(messaging, (payload) => {
//   console.log('[firebase-messaging-sw.js] Received background message ', payload);
//   // Customize notification here
//   const notificationTitle = 'Background Message Title';
//   const notificationOptions = {
//     body: 'Background Message body.',
//     icon: 'favicon.png'
//   };

//   self.registration.showNotification(notificationTitle,
//     notificationOptions);
// });

const messaging = firebase.messaging();


Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});

