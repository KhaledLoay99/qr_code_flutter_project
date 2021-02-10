import 'package:Dcode/ui/navigatorBar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    if (_userid.toString() != "-1") {
      setState(() {
        openChat(FirebaseAuth.instance.currentUser.uid, _userid);
      });
    }
  }

  Future<void> openChat(String myid, String userid) async {
    if (myid != userid) {
      await Firebase.initializeApp();
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('users');
      var list = [myid, userid];
      list.sort();
      DocumentSnapshot variable = await collectionReference.doc(userid).get();
      DocumentSnapshot variable2 = await collectionReference.doc(myid).get();

      if (variable.exists) {
        var list = variable2['chatlist'];
        for (var x in list) {
          if (x['userid'] == userid) {
            return;
          }
        }

        var username = variable['username'];
        var myusername = variable2['username'];
        var now = new DateTime.now();

        Map<String, dynamic> chatlist = {
          'chatlist': FieldValue.arrayUnion([
            {
              'userid': myid,
              'username': myusername,
              'date': now,
            }
          ])
        };
        collectionReference.doc(userid).update(chatlist);
        Map<String, dynamic> chatlist2 = {
          'chatlist': FieldValue.arrayUnion([
            {
              'userid': userid,
              'username': username,
              'date': now,
            }
          ])
        };
        collectionReference.doc(myid).update(chatlist2);
        setState(() {
          _value = "Waiting.....";
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage('something')),
            (Route<dynamic> route) => false,
          );
        });
      } else {
        setState(() {
          _value = "User Not Found";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
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
                    color: Colors.white,
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
                "Scanned: " + _value,
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
