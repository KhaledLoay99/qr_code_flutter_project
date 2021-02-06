import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final void Function(String email, String password, BuildContext ctx) submitFn;
  final bool _isLoading;
  Login(this.submitFn, this._isLoading);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();
  String _savedDataUsername = "";
  String _savedDataPassword = "";
  bool _showPassword = false;

  var _usernameField = new TextEditingController();
  var _passwordField = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (sharedPreferences.getString('username') != null &&
          sharedPreferences.getString('username').isNotEmpty) {
        _savedDataUsername = sharedPreferences.getString('username');
      }
      if (sharedPreferences.getString('password') != null &&
          sharedPreferences.getString('password').isNotEmpty) {
        _savedDataPassword = sharedPreferences.getString('password');
      } else {
        _savedDataPassword = '';
      }
    });
  }

  _saveData(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('username', username);
    sharedPreferences.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    _usernameField.text = _savedDataUsername;
    _passwordField.text = _savedDataPassword;
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
        child: ListView(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Center(
              child: new Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 55,
                    color: Colors.blue),
              ),
            ),
            Container(
              padding: EdgeInsets.all(50.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _usernameField,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Email';
                      }
                      if (!value.contains('.com')) {
                        return 'Invalid Email';
                      }
                      if (!value.contains('@')) {
                        return 'Invalid Email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                      hintText: 'Email',
                      icon: new Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(20.0)),
                  TextFormField(
                    controller: _passwordField,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Your Password';
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                      hintText: 'Password',
                      icon: new Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: this._showPassword ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          setState(
                              () => this._showPassword = !this._showPassword);
                        },
                      ),
                    ),
                    obscureText: !this._showPassword,
                  ),
                  widget._isLoading
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 26.0),
                          child: RaisedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                widget.submitFn(
                                  _usernameField.text.trim(),
                                  _passwordField.text.trim(),
                                  context,
                                );
                                // If the form is valid, Go to Home screen.
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => home()),
                                // );

                                _saveData(
                                    _usernameField.text, _passwordField.text);
                              }
                            },
                            child: Text('Login'),
                            color: Colors.cyan,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
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
