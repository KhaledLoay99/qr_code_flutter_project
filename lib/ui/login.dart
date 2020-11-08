import 'package:flutter/material.dart';
import 'package:Dcode/ui/home.dart';
import 'package:Dcode/ui/signup.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
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


      body: new Container(

        alignment: Alignment.topCenter,
        child: new Column(
          children: <Widget>[

            new Padding(padding: new EdgeInsets.all(20.0)),
            new Text("Login", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 55,color: Colors.blue),),
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Container(
              height: 500,
              width: 380,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(30.0),
                child: new Column(
                  children: <Widget>[
                    new Center(
                      //child: new Text("Login", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blue),),
                    ),
                    new TextField(
                      decoration: new InputDecoration(
                          hintText: 'Username', icon: new Icon(Icons.person)),
                    ),

                    
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    //new Padding(padding: new EdgeInsets.all(20.0)),
                    
                    new TextField(
                      decoration: new InputDecoration(
                          hintText: 'Password', icon: new Icon(Icons.lock)),
                      obscureText: true,
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    new Center(
                        child: new RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => home()),
                            );
                          },
                          child: new Text(
                            "Login",
                            style: new TextStyle(
                                color: Colors.blueGrey, fontSize: 20.5),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
