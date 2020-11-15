import 'package:flutter/material.dart';
import 'package:Dcode/ui/login.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  Color c1 = const Color.fromRGBO(110,204,234,1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();
  static final  validCharacters = RegExp(r"^[a-zA-Z]+$");
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


      body: Form(
        key: _formKey,
        child: Column(

          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 55,color: Colors.blue),),
            Container(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter First Name';
                        }
                        if(value.length < 3){
                          return 'First Name is too short';
                        }
                        if(value.length > 18){
                          return 'First Name is too long';
                        }
                        if (!validCharacters.hasMatch(value)) {
                          return 'First Name should be alphabets only';
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                          hintText: 'First Name', icon: new Icon(Icons.person),
                      ),
                    ),

                    new Padding(padding: new EdgeInsets.all(20.0)),

                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Last Name';
                        }
                        if(value.length < 3){
                          return 'Last Name is too short';
                        }

                        if(value.length > 18){
                          return 'Last Name is too long';
                        }


                        if (!validCharacters.hasMatch(value)) {
                          return 'Last Name should be alphabets only';
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                          hintText: 'Last Name', icon: new Icon(Icons.person)
                      ),
                    ),

                    new Padding(padding: new EdgeInsets.all(20.0)),

                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Username';
                        }
                        if(value.length > 25){
                          return 'Username is too long';
                        }
                        if(value.length < 11){
                          return 'Username is too short';
                        }
                        if(!value.contains('@dcode.com')){
                          return 'username should end with @decode.com';
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                          hintText: 'Username', icon: new Icon(Icons.account_circle)
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        if(value.length > 25){
                          return 'Password is too long';
                        }
                        if(value.length < 5){
                          return 'Password is too short';
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                          hintText: 'Password', icon: new Icon(Icons.lock)
                      ),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 26.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, Go to Home screen.
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          }
                        },
                        child: Text('Sign Up'),
                      ),
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