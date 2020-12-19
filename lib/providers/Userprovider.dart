import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Dcode/logic/userProfile.dart';

class Userprovider with ChangeNotifier {
  Userprovider() {
    fetchdata();
    //print(user);
  }
  List<Userprofile> user = [];
  bool prog = true;
  Future<void> fetchdata() async {
    const url = "https://dcode-bd3d1-default-rtdb.firebaseio.com/User.json";
    try {
      final http.Response res = await http.get(url);
      /* http.post(url,
        body: json.encode({
          "Email": "RL9@gmail.com",
          "FirstName": "Robert",
          "LastName": "Lewandowski",
          "FirstName": "Robert",
          "Location": "Wursaw, Poland",
          "FirstName": "Robert",
          "profileImage": "images/profile.jpg",
          "qrImage": "images/car.png",
        }));*/
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((userid, userData) {
        user.add(Userprofile(
          id: userid,
          email: userData['Email'],
          firstname: userData['FirstName'],
          lastname: userData['LastName'],
          location: userData['Location'],
          profileImage: userData['profileImage'],
          qrImage: userData['qrImage'],
        ));
      });
      prog = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
