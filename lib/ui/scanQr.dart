import 'package:flutter/material.dart';

class scanQr extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return scanQrState();
  }
}

class scanQrState extends State<scanQr> {
  Color c1 = const Color.fromRGBO(110,204,234,1.0); // fully transparent white (invisible)

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
      body: new Container(),
    );
  }
}