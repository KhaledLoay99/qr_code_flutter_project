import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Dcode/logic/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Userprovider with ChangeNotifier {
  Userprovider() {
    fetchdata();
    //print(user);
  }
  List<Userprofile> user = [];
  bool prog = true;
  bool err = false;
  Future<void> updateData(String id) async {
    const url = "https://dcode-bd3d1-default-rtdb.firebaseio.com/User.json";
    final userIndex = user.indexWhere((element) => element.id == id);
    await http.patch(url,
        body: json.encode({
          "Email": "RL9@gmail.com",
          "FirstName": "Robert",
          "LastName": "Lewandowski",
          "FirstName": "Robert",
          "Location": "Wursaw, Poland",
          "FirstName": "Robert",
          "profileImage": "images/profile.jpg",
          "qrImage": "images/car.png",
        }));
    notifyListeners();
  }

  Future<void> fetchdata() async {
    //const url = "https://dcode-bd3d1-default-rtdb.firebaseio.com/User.json";
    await Firebase.initializeApp();
    var snaps = FirebaseFirestore.instance.collection('user');
    try {
      /*snaps.getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((DocumentSnapshot doc) {
          print("Hello");
          print(doc.data);
        });
        prog = false;
        notifyL*/
      snaps.snapshots().listen((QuerySnapshot querySnapshot) {
        print('Hello');
        querySnapshot.documents.forEach((document) {
          user.add(Userprofile(
            id: document.documentID,
            email: document.data()['username'],
            firstname: document.data()['firstname'],
            lastname: document.data()['lastname'],
            location: document.data()['location'],
            profileImage: document.data()['profileImage'],
            qrImage: document.data()['qrImage'],
          ));

          document.data();
        });
        snaps.get().then((value) {
          prog = false;
          notifyListeners();
        });
      });
    } catch (error) {
      prog = false;
      err = true;
      notifyListeners();
      //throw error;
    }
  }
}
