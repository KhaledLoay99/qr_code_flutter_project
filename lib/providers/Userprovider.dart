import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Userprofile {
  final String id;
  final String Email;
  final String FirstName;
  final String LastName;
  final String Location;
  final String profileImage;
  final String qrImage;

  Userprofile({
    @required this.id,
    @required this.Email,
    @required this.FirstName,
    @required this.LastName,
    @required this.Location,
    @required this.profileImage,
    @required this.qrImage,
  });
}

class Userprovider with ChangeNotifier {
  List<Userprofile> user = [];
  Future<void> fetchdata() async {
    const url = "https://dcode-bd3d1-default-rtdb.firebaseio.com/User.json";
    try {
      final http.Response res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((userid, userData) {
        user.add(Userprofile(
          id: userid,
          Email: userData['Email'],
          FirstName: userData['FirstName'],
          LastName: userData['LastName'],
          Location: userData['Location'],
          profileImage: userData['profileImage'],
          qrImage: userData['qrImage'],
        ));
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
