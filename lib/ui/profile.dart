import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Profile extends StatefulWidget {
  @override
  static Pattern pattern;
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _controller = new TextEditingController();
  TextFormField test;
  bool _isEnabled;
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  final _formKey = GlobalKey<FormState>();
  TextEditingController _customController;
  createAlertDialog(BuildContext context, String type, String val) {
    _customController = new TextEditingController(text: val);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Your $type"),
            content: Container(
              height: 125,
              width: 250,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (type == "FirstName") {
                          if (value.isEmpty) {
                            return 'Please Enter First Name';
                          }
                          if (value.length < 3) {
                            return 'First Name is too short';
                          }
                          if (value.length > 18) {
                            return 'First Name is too long';
                          }
                          if (!validCharacters.hasMatch(value)) {
                            return 'First Name should be alphabets only';
                          }
                          return null;
                        }
                        if (type == "LastName") {
                          if (value.isEmpty) {
                            return 'Please Enter Last Name';
                          }
                          if (value.length < 3) {
                            return 'Last Name is too short';
                          }

                          if (value.length > 18) {
                            return 'Last Name is too long';
                          }
                          if (!validCharacters.hasMatch(value)) {
                            return 'Last Name should be alphabets only';
                          }
                          return null;
                        }
                        if (type == "Email") {
                          if (value.isEmpty) {
                            return 'Please Enter Username';
                          }
                          if (value.length > 25) {
                            return 'Username is too long';
                          }
                          if (value.length < 11) {
                            return 'Username is too short';
                          }
                          if (!value.contains('@dcode.com')) {
                            return 'username should end with @decode.com';
                          }
                          return null;
                        }
                      },
                      controller: _customController,
                    ),
                    MaterialButton(
                      elevation: 5.0,
                      child: Text('Submit'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, Go to Home screen.
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget textfield({@required String hintText, bool qr, String type}) {
    return Material(
        elevation: 4,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          child: Stack(children: [
            test = TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    letterSpacing: 2,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none)),
            ),
            Row(children: [
              Container(
                padding: qr
                    ? EdgeInsets.only(left: 320, top: 20)
                    : EdgeInsets.only(left: 310, top: 10),
                child: qr
                    ? Icon(Icons.center_focus_weak)
                    : IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          createAlertDialog(context, type, hintText);
                        },
                      ),
              )
            ])
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
      ),
      body: ListView(children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Stack(alignment: Alignment.topCenter, children: [
              CustomPaint(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                painter: HeaderCurvedContainer(),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 35,
                          letterSpacing: 1.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          //padding: EdgeInsets.all(0.0),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle,
                              color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage('images/profile.jpg'))),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 140, left: 184),
                          margin: EdgeInsets.only(bottom: 50),
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /*Padding(
                  padding: EdgeInsets.only(top: 100, left: 184),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),*/
                Container(
                  padding: EdgeInsets.only(top: 150),
                  height: 550,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textfield(
                          hintText: 'Robert', qr: false, type: "FirstName"),
                      textfield(
                          hintText: 'Lewandowski', qr: false, type: "LastName"),
                      textfield(
                          hintText: 'RL9@dcode.com', qr: false, type: "Email"),
                      textfield(
                          hintText: 'Warsaw, Poland',
                          qr: false,
                          type: "Location"),
                      textfield(
                        hintText: 'QR Code',
                        qr: true,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromRGBO(110, 204, 234, 1.0);
    Path path = Path()
      ..lineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
