import 'package:flutter/material.dart';

class Userprofile {
  String id;
  String username;
  String email;
  String location;
  String profileImage;
  String qrImage;
  int noOfChats;
  Userprofile({
    @required this.id,
    @required this.email,
    @required this.username,
    @required this.location,
    @required this.profileImage,
    @required this.qrImage,
    @required this.noOfChats,
  });

  String get get_username {
    return username;
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

  int get get_noOfChats {
    return noOfChats;
  }
}
