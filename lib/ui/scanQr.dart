import 'package:Dcode/ui/chatlist.dart';
import 'package:Dcode/ui/navigatorBar.dart';
import 'package:Dcode/ui/notification.dart';
import 'package:flutter/material.dart';
import 'package:Dcode/ui/home.dart';
import 'package:Dcode/ui/profile.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class scanQr extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return scanQrState();
  }
}

class scanQrState extends State<scanQr> {
  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  String _userid, _value = "";

  Future scanUser() async {
    _userid = await FlutterBarcodeScanner.scanBarcode(
        "#004297", "Cancel", true, ScanMode.DEFAULT);

    setState(() {
      _value = _userid;
      openChat(FirebaseAuth.instance.currentUser.uid, _userid);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage('something')),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<void> openChat(String myid, String userid) async {
    await Firebase.initializeApp();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
//          title: new Text("Login"),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: c1,
//         selectedItemColor: Colors.black45,
// //        unselectedItemColor: Colors.white.withOpacity(.60),
// //        selectedFontSize: 14,
// //        unselectedFontSize: 14,
//         onTap: (value) {
//           // Respond to item press.
//           if (value == 0) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => home()),
//             );
//           } else if (value == 1) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => notify()),
//             );
//           } else if (value == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => chatlist()),
//             );
//           } else if (value == 3) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Profile()),
//             );
//           }
//         },
//         items: [
//           BottomNavigationBarItem(
//             title: Text('Home'),
//             icon: Icon(Icons.home),
//           ),
//           BottomNavigationBarItem(
//             title: Text('Notifications'),
//             icon: Icon(Icons.notifications),
//           ),
//           BottomNavigationBarItem(
//             title: Text('Recent Chats'),
//             icon: Icon(Icons.chat),
//           ),
//           BottomNavigationBarItem(
//             title: Text('My Profile'),
//             icon: Icon(Icons.account_circle),
//           ),
//         ],
//       ),
      body: new ListView(
        //alignment: Alignment.topCenter,
        children: [
          new Column(
            children: <Widget>[
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Text(
                "Scan New Qr",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.blue),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor,
                    borderRadius: BorderRadius.circular(8.0),
                    image: new DecorationImage(
                      image: new AssetImage("images/qr-code.png"),
                      fit: BoxFit.fill,
                    )),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Text(
                "Click below Camer Button To Scan",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue),
              ),
              Text(
                "Scanned:" + _value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanUser,
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
