import 'package:Dcode/ui/login.dart';
import 'package:Dcode/ui/navigatorBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AuthFormLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuthFormLoginState();
  }
}

class AuthFormLoginState extends State<AuthFormLogin> {
  final _auth = FirebaseAuth.instance;
  UserCredential _authResult;
  bool _isLoading = false;

  void _submitAuthForm_signin(
      String email, String password, BuildContext ctx) async {
    try {
      setState(() {
        _isLoading = true;
      });

      _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Navigator.of(context).pushReplacement(
      //     new MaterialPageRoute(builder: (BuildContext context) => home()));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false, // remove back arrow
      );
    } on FirebaseAuthException catch (e) {
      String message = "error Occured";
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
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
      body: Login(_submitAuthForm_signin, _isLoading),
    );
  }
}
