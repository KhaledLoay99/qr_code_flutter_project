import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
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
            new Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 55,color: Colors.blue),),
            new Padding(padding: new EdgeInsets.all(10.0)),
            new Container(
              //height: double.infinity,
              height: 550,
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
                        hintText: 'First Name', icon: new Icon(Icons.person)),
                  ),
                  new Padding(padding: new EdgeInsets.all(20.0)),
                  new TextField(
                    decoration: new InputDecoration(
                        hintText: 'Last Name', icon: new Icon(Icons.person)),
                  ),

                  new Padding(padding: new EdgeInsets.all(20.0)),

                  new TextField(
                    decoration: new InputDecoration(
                        hintText: 'Enter Username', icon: new Icon(Icons.person)),
                  ),

                  //new Padding(padding: new EdgeInsets.all(10.0)),
                  new Padding(padding: new EdgeInsets.all(20.0)),

                  new TextField(
                    decoration: new InputDecoration(
                        hintText: 'Enter New Password', icon: new Icon(Icons.lock)),
                    obscureText: true,
                  ),


                  new Padding(padding: new EdgeInsets.all(20.0)),


                  new TextField(
                    decoration: new InputDecoration(
                        hintText: 'Repeat Password', icon: new Icon(Icons.lock)),
                    obscureText: true,
                  ),

                  new Padding(padding: new EdgeInsets.all(20.0)),

                  new Center(
                      child: new RaisedButton(
                        child: new Text(
                          "Sign Up",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 20.5),
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