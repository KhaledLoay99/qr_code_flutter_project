import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

const fcm = admin.messaging();
// const db = admin.firestore();


export const sendToTopic = functions.firestore
  .document('messages/{messages}')


  .onCreate(async snapshot => {
    const dat = snapshot.data();

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: dat.sentby,
        body: dat.text,
        sound:'defualt',
        icon:'dcodeLogo.jpg',
        click_action: 'FLUTTER_NOTIFICATION_CLICK', // required only for onResume or onLaunch callbacks
      },
    };

    return fcm.sendToTopic('messages', payload);
  });



// export const sendToDevice = functions.firestore
//   .document('messages/{messages}')
//   .onCreate(async snapshot => {


//     const order = snapshot.data();

//     const querySnapshot = await db
//       .collection('users')
//       .doc(order.seller)
//       .get();

//     const tokens = querySnapshot.docs.map(snap => snap.id);

//     const payload: admin.messaging.MessagingPayload = {
//       notification: {
//         title: 'New Order!',
//         body: `you sold a ${order.product} for ${order.total}`,
//         icon: 'your-icon-url',
//         click_action: 'FLUTTER_NOTIFICATION_CLICK'
//       }
//     };

//     return fcm.sendToDevice(tokens, payload);
//   });