import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  //sendMessage("zzzzzz", "azzzzz", "hello");
  //openChat('ASOeN1fvNw6ZPWasfKds', 'RNSfI3qlpmudY9rwRsnY');
}

Future<void> sendMessage(String myid, String userid, String text) async {
  await Firebase.initializeApp();
  var list = [myid, userid];
  list.sort();
  Map<String, dynamic> messageInfo = {
    'date': FieldValue.serverTimestamp(),
    'sentby': myid,
    'text': text,
    "userid1": list[0],
    'userid2': list[1]
  };
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('messages');
  collectionReference.add(messageInfo);
}

Future<void> checklist(String userid, String myid) async {
  await Firebase.initializeApp();
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user');
  DocumentSnapshot variable = await collectionReference.doc(userid).get();
  var username = variable['username'];
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('users')
      .where('language',
          arrayContainsAny: ['{"username":$username,"userid":$userid}']).get();
  final List<DocumentSnapshot> documents = result.docs;
  if (documents.length > 0) {
    //exists

  } else {
    openChat(userid, myid);
  }
}

Future<void> openChat(String myid, String userid) async {
  await Firebase.initializeApp();
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user');
  var list = [myid, userid];
  list.sort();
  DocumentSnapshot variable = await collectionReference.doc(userid).get();
  DocumentSnapshot variable2 = await collectionReference.doc(myid).get();

  var username = variable['username'];
  var myusername = variable2['username'];

  Map<String, dynamic> chatlist = {
    'chatlist': FieldValue.arrayUnion([
      {'userid': myid, 'username': myusername}
    ])
  };
  collectionReference.doc(userid).update(chatlist);
  Map<String, dynamic> chatlist2 = {
    'chatlist': FieldValue.arrayUnion([
      {'userid': userid, 'username': username}
    ])
  };
  collectionReference.doc(myid).update(chatlist2);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo'),
        ),
        body: chatlist());
  }
}

class chat extends StatelessWidget {
  @override
  var myuserid = "ASOeN1fvNw6ZPWasfKds";
  Widget build(BuildContext context) {
    Query users = FirebaseFirestore.instance
        .collection('messages')
        .where("userid1", isEqualTo: "ASOeN1fvNw6ZPWasfKds")
        .where("userid2", isEqualTo: "RNSfI3qlpmudY9rwRsnY")
        .orderBy('date');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            if (document.data()['sentby'] == myuserid) {
              return new ListTile(
                title: new Text(
                  document.data()['text'],
                  textAlign: TextAlign.right,
                ),
              );
            } else {
              return new ListTile(
                title: new Text(
                  document.data()['text'],
                  textAlign: TextAlign.left,
                ),
              );
            }
          }).toList(),
        );
      },
    );
  }
}

class chatlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc('ASOeN1fvNw6ZPWasfKds')
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var courseDocument = snapshot.data.data;
          var sections = courseDocument()['chatlist'];
          return ListView.builder(
            itemCount: sections != null ? sections.length : 0,
            itemBuilder: (_, int index) {
              print(sections[index]['username']);
              return ListTile(title: Text(sections[index]['username']));
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
// class UserListState extends State<UserList> {
//   Color c1 = const Color.fromRGBO(
//       110, 204, 234, 1.0); // fully transparent white (invisible)
//   final _biggerFont = const TextStyle(fontSize: 18.0);

//   // #enddocregion RWS-var

//   // #docregion _buildSuggestions
//   Widget _buildChatList() {
//     var imageUrl;
//     return StreamBuilder<DocumentSnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .doc('4au4PFwK3mRrkG77pwLZU9EusFs1')
//           .snapshots(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           var courseDocument = snapshot.data.data;
//           var sections = courseDocument()['chatlist'];
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text("Loading");
//           }
//           return ListView.separated(
//             padding: const EdgeInsets.all(16.0),
//             itemBuilder: /*1*/ (context, index) {
//               // imageUrl = loadAsset(sections[index]['imagepath']);

//               // try {
//               //   var ref = await FirebaseStorage.instance
//               //       .ref()
//               //       .child(sections[index]['imagepath']);
//               //   ref.getDownloadURL().then((loc) {
//               //     imageUrl = loc;
//               //     log(imageUrl);
//               //   });
//               // } catch (error) {
//               //   imageUrl = null;
//               // }
//               // var firebaseStorageRef = FirebaseStorage.instance
//               //     .ref()
//               //     .child(sections[index]['imagepath']);
//               imageUrl =
//                   "https://firebasestorage.googleapis.com/v0/b/dcode-bd3d1.appspot.com/o/" +
//                       sections[index]['imagepath'] +
//                       "?alt=media";
//               return ListTile(
//                 leading: CircleAvatar(
//                   child: Row(
//                     children: <Widget>[
//                       (imageUrl == null)
//                           ? Image.asset('images/chat.png')
//                           : Image.network(imageUrl)
//                     ],
//                   ),
//                 ),
//                 title: Text(
//                   sections[index]['username'],
//                   style: _biggerFont,
//                 ),
//                 trailing: Icon(Icons.arrow_right),
//                 onTap: () {
//                   // send to chat screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => privateChat()),
//                   );
//                 },
//               );
//               ;
//             },
//             separatorBuilder: (context, index) {
//               return Divider();
//             },
//             itemCount: sections.length,
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
