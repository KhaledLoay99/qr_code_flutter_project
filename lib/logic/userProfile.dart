import 'package:flutter/material.dart';

class Userprofile {
  String id;
  String firstname;
  String lastname;
  String email;
  String location;
  String profileImage;
  String qrImage;
  Userprofile({
    @required this.id,
    @required this.email,
    @required this.firstname,
    @required this.lastname,
    @required this.location,
    @required this.profileImage,
    @required this.qrImage,
  });
  String get first_name {
    return firstname;
  }

  String get last_name {
    return lastname;
  }

  String get get_mail {
    return email;
  }

  String get get_location {
    return location;
  }

  String get get_profileImage {
    return profileImage;
  }

  String get get_qrImage {
    return qrImage;
  }
}
