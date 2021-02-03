const functions = require('firebase-functions');
const admin= require('firebase-admin');

admin.initializeApp();

exports.myFunction= functions.firestore.document('messages/{message}').onCreate((snapshot,context)=>
{

	return admin.messaging().sendToTopic('messages',{
notification :{
	title: snapshot.data().sentby,
	body:snapshot.data().text,
	clickAction:"FLUTTER_NOTIFICATION_CLICK",
},


	});
});
