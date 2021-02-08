import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();




// const db = admin.firestore();


export const sendToTopic = functions.firestore
  .document('messages/{messages}')
  .onCreate(async snapshot => {


    const dat = snapshot.data();

    const querySnapshot = await db
      .collection('users')
      .doc(dat.receivedby)
      .collection('tokens')
      .get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: dat.sendername,
        body: dat.text,
        sound:'defualt',
        icon:'images/dcodeLogo.jpg',
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
    };

    return fcm.sendToDevice(tokens, payload);
  });






