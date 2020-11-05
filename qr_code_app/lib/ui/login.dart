import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(


        appBar: new AppBar(
        title: new Text("Login"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: new Container(
        alignment: Alignment.topCenter,
        child: new Column(
          children: <Widget>[
            new Image.asset(
              'images/Dcode_home.jpg',
              width: 1500.0,
              height: 150.0,
            ),
            new Container(
              height: 180,
              width: 380,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    decoration: new InputDecoration(
                        hintText: 'Username', icon: new Icon(Icons.person)),
                  ),
                  new TextField(
                    decoration: new InputDecoration(
                        hintText: 'Password', icon: new Icon(Icons.lock)),
                    obscureText: true,
                  ),

                  new Center(
                      child: new RaisedButton(
                        child: new Text(
                          "Login",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 20.5),
                        ),

                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}