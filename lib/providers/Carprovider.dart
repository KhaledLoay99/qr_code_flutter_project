import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Dcode/logic/carProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Carprovider with ChangeNotifier {
  Carprovider() {
    //fetchdata();
  }
  List<Carprofile> car = [];
  bool prog = true;
  bool err = false;
  Future<void> fetchdata() async {
    await Firebase.initializeApp();
    //var snaps = FirebaseFirestore.instance.collection('user');
    try {
      var snaps = FirebaseFirestore.instance.collection('car');
      snaps.snapshots().listen((QuerySnapshot querySnapshot) {
        if (querySnapshot.size > 0) {
          querySnapshot.documents.forEach((document) async {
            car.add(Carprofile(
              userid: await document.data()['userid'],
              location: await document.data()['Location'],
              salestatus: await document.data()['SaleStatus'],
              carmodel: await document.data()['carModel'],
              carprofileImage: await document.data()['CarProfileImage'],
            ));
          });
          snaps.get().then((value) {
            //prog = false;
            notifyListeners();
          });
        } else {
          prog = false;
          err = true;
          notifyListeners();
        }
      });
    } catch (error) {
      prog = false;
      err = true;
      notifyListeners();
    }
  }
}
