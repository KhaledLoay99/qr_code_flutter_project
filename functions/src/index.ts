import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();


const fcm = admin.messaging();

export const sendToTopic = functions.firestore
  .document('messages/{messages}')


  .onCreate(async snapshot => {
    const dat = snapshot.data();

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: dat.sentby,
        body: dat.text,
        click_action: 'FLUTTER_NOTIFICATION_CLICK', // required only for onResume or onLaunch callbacks
      },
    };

    return fcm.sendToTopic('messages', payload);
  });