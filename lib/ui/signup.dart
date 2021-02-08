import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  final void Function(
          String email, String password, String username, BuildContext ctx)
      submitFn;
  final bool _isLoading;
  Signup(this.submitFn, this._isLoading);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  var _email = new TextEditingController();
  var _username = new TextEditingController();
    Pattern pattern2 = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  var _password = new TextEditingController();
  Pattern pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  Widget build(BuildContext context) {
      RegExp regex = new RegExp(pattern);
      RegExp regex2 = new RegExp(pattern2);
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
//          title: new Text("Login"),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Center(
              child: new Text(
                "Sign Up",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 55,
                    color: Colors.blue),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _username,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter a Username';
                        }
                        if (value.length < 3) {
                          return 'Username is too short';
                        }
                        if (value.length > 18) {
                          return 'Username is too long';
                        }
                        // if (!validCharacters.hasMatch(value)) {
                        //   return 'First Name should be alphabets only';
                        // }
                        return null;
                      },
                      decoration: new InputDecoration(
                        hintText: 'Username',
                        icon: new Icon(Icons.person),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    TextFormField(
                      controller: _email,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        // if (value.length > 35) {
                        //   return 'Email is too long';
                        // }
                        // if (value.length < 11) {
                        //   return 'Email is too short';
                        // }
                        if (!regex.hasMatch(value)) {
                          return 'Invalid Email format';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        hintText: 'Email',
                        icon: new Icon(Icons.account_circle),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    TextFormField(
                      controller: _password,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        if (value.length > 30) {
                          return 'Password is too long';
                        }
                        if (value.length < 8) {
                          return 'Password is too short';
                        }
                        if(!regex2.hasMatch(value))
                        {
                          return 'contains at least one lowercase letter and one uppercase letter and one number and one special Character ';
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                        hintText: 'Password',
                        icon: new Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    widget._isLoading
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 26.0),
                            child: SizedBox(
                              width: 160,
                              child: RaisedButton(
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, Go to Home screen.
                                    widget.submitFn(
                                      _username.text.trim(),
                                      _email.text.trim(),
                                      _password.text.trim(),
                                      context,
                                    );

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => Login()),
                                    // );

                                  }
                                },
                                child: Text('Sign Up'),
                                color: Colors.cyan,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
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
