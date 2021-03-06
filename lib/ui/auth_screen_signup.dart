import 'dart:io';

import 'package:Dcode/ui/navigatorBar.dart';
import 'package:Dcode/ui/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuthFormState();
  }
}

class AuthFormState extends State<AuthForm> {
  final FirebaseMessaging fbm = FirebaseMessaging();
  final _auth = FirebaseAuth.instance;
  UserCredential userCredential;
  bool _isLoading = false;
  String location = "No Location Added";
  String profileImage = null;

  FirebaseFirestore db = FirebaseFirestore.instance;

  String carProfileImage = null;
  String car_location = "No Location Added";
  bool saleStatus = false;
  String carModel = "No Car Model Added";
  bool check = true;
  void _submitAuthForm(
      String username, String email, String password, BuildContext ctx) async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (username == result["username"]) {
          return check = false;
        }
      });
    });
    if (check == false) {
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text("username already exists"),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
        check = true;
      });
    } else {
      try {
        setState(() {
          _isLoading = true;
        });

        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String fcmToken = await fbm.getToken();
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'username': username,
          'location': location,
          'profileImage': profileImage,
        });

        FirebaseFirestore.instance
            .collection('cars')
            .doc(userCredential.user.uid)
            .set({
          'userid': userCredential.user.uid,
          'CarProfileImage': carProfileImage,
          'Location': car_location,
          'SaleStatus': saleStatus,
          'carModel': carModel
        });

        var tokens = db
            .collection('users')
            .doc(userCredential.user.uid)
            .collection('tokens')
            .doc(fcmToken);
        await tokens.set({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
          'platform': Platform.operatingSystem // optional
        });

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage('')),
          (Route<dynamic> route) => false, // remove back arrow
        );
      } on FirebaseAuthException catch (e) {
        String message = "error Occured";
        if (e.code == 'weak-password') {
          message = "The password provided is too weak";
        } else if (e.code == 'email-already-in-use') {
          message = "The account already exists for that email";
        }
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Signup(_submitAuthForm, _isLoading),
    );
  }
}
