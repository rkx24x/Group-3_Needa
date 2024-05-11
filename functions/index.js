/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.sendPushNotification = functions.https.onCall((data) => {
  const { tokens, title, body, needaRecordId } = data; // Use destructuring for clearer access to properties

  const message = {
    notification: {
      title: title, // Title of the notification
      body: body, // Body of the notification
    },
    data: {
      needaRecordId: needaRecordId // Pass this data along with the notification
    },
    tokens: tokens, // FCM device tokens array
  };

  return admin.messaging().sendMulticast(message)
    .then((response) => ({ success: true, response }))
    .catch((error) => ({ success: false, error: error.message }));
});
