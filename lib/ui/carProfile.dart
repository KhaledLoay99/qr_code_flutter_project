import 'package:Dcode/logic/carProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class carProfile extends StatefulWidget {
  @override
  static Pattern pattern;
  _carProfileState createState() => _carProfileState();
}

class _carProfileState extends State<carProfile> {
  final TextEditingController _controller = new TextEditingController();
  TextFormField test;
  bool _isEnabled;
  var _val = false;
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  static final validNumbers = RegExp('[0-9]');
  final _formKey = GlobalKey<FormState>();
  TextEditingController _customController;
  Carprofile carprofileData = new Carprofile();
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
                        if (type == "CarName") {
                          if (value.isEmpty) {
                            return 'Please Enter Car Name';
                          }
                          if (value.length < 3) {
                            return 'Car Name is too short';
                          }
                          if (value.length > 18) {
                            return 'Car Name is too long';
                          }
                          return null;
                        }
                        if (type == "Status") {
                          if (value.isEmpty) {
                            return 'Please Enter Status';
                          }
                          if (value.length < 3) {
                            return 'Status is too short';
                          }

                          if (value.length > 18) {
                            return 'Status is too long';
                          }
                          if (!validCharacters.hasMatch(value)) {
                            return 'Status should be alphabets only';
                          }
                          return null;
                        }
                        if (type == "Location") {
                          if (value.isEmpty) {
                            return 'Please Enter your Location';
                          }
                          if (value.length > 35) {
                            return 'Location is too long';
                          }
                          if (value.length < 11) {
                            return 'Location is too short';
                          }
                          return null;
                        }
                        if (type == "PhoneNumber") {
                          if (value.isEmpty) {
                            return 'Please Enter your Phone Number';
                          }
                          if (value.length > 35) {
                            return 'Phone Number is too long';
                          }
                          if (value.length < 11) {
                            return 'Phone Number is too short';
                          }
                          if (!new RegExp(
                                  r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$')
                              .hasMatch(value)) {
                            return 'Phone Number should be in numbers only';
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

  Widget textfield({@required String hintText, String type}) {
    //var val = false;
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
                padding: EdgeInsets.only(left: 310, top: 10),
                child: type == "Status"
                    ? Container(
                        width: 60,
                        height: 30,
                        child: Switch(
                          value: _val,
                          onChanged: (value) {
                            setState(() {
                              _val = value;
                            });
                          },
                        ))
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
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
      ),
      body: ListView(physics: const NeverScrollableScrollPhysics(), children: [
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
                        "Car Profile",
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
                          alignment: Alignment.center,
                          //padding: EdgeInsets.all(0.0),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                      carprofileData.get_carprofileImage))),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 140,
                              left: MediaQuery.of(context).size.width / 2.2),
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
                Container(
                  padding: EdgeInsets.only(top: 150),
                  height: 550,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textfield(
                          hintText: carprofileData.get_carmodel,
                          type: "CarName"),
                      textfield(
                          hintText: carprofileData.get_salestatus,
                          type: "Status"),
                      textfield(
                          hintText: carprofileData.get_location,
                          type: "Location"),
                      textfield(
                          hintText: carprofileData.get_phonenumber,
                          type: "PhoneNumber"),
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
