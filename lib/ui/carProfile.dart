import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Dcode/providers/Carprovider.dart';
import "package:provider/provider.dart";
import 'package:toggle_switch/toggle_switch.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class carProfile extends StatefulWidget {
  @override
  static Pattern pattern;
  final String nUser;
  _carProfileState createState() => _carProfileState(nUser);
  carProfile({Key key, this.nUser}) : super(key: key);
}

class _carProfileState extends State<carProfile> {
  String nUser;
  _carProfileState(this.nUser);
  final TextEditingController _controller = new TextEditingController();
  TextFormField test;
  bool _isEnabled;
  var val = false;
  List carList;
  static final validCharacters = RegExp(r"^(?:.*[a-zA-Z].*){5}");
  static final validCharacters2 = RegExp(r"^(?:.*[a-zA-Z].*){5}");
  static final validNumbers = RegExp('[0-9]');
  final _formKey = GlobalKey<FormState>();
  TextEditingController _customController;
  bool prog = true;
  bool err = false;
  var update;
  File uImage;
  String _imageUrl;
  var user_id;
  int carIndex;
  var ref;

  @override
  void initState() {
    Provider.of<Carprovider>(this.context, listen: false)
        .fetchdata()
        .then((value) {
      prog = false;
    });
    update = Provider.of<Carprovider>(this.context, listen: false);
    var uPic;
    if (nUser == null)
      uPic = FirebaseAuth.instance.currentUser.uid;
    else
      uPic = nUser;
    try {
      ref = FirebaseStorage.instance.ref().child('car' + uPic + '.png');
      ref.getDownloadURL().then((loc) {
        setState(() {
          _imageUrl = loc;
        });
      });
    } catch (error) {
      _imageUrl = null;
    }
    super.initState();
  }

  createAlertDialog(BuildContext context, String type, String val) {
    _customController = new TextEditingController(text: val);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: type == 'carModel'
                ? Text("Your car Model")
                : Text("Your $type"),
            content: Container(
              height: 125,
              width: 250,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (type == "carModel") {
                          if (value.isEmpty) {
                            return 'Please Enter Car Model';
                          }
                          if (value.length < 5) {
                            return 'Car Model is too short';
                          }
                          if (value.length > 25) {
                            return 'Car Model is too long';
                          }
                          /* if (new RegExp(r'[ !@#$%^&*(),.?":{}|<>]$')
                              .hasMatch(value)) {
                            return "Car Name shouldn't contain any symbols";
                          }*/
                          if (!validCharacters.hasMatch(value)) {
                            return "Car Model should contain at least 5 letters";
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
                          if (!validCharacters.hasMatch(value)) {
                            return "Location should contain at least 5 letters";
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
                          update.updateData(
                              user_id,
                              type == 'carModel'
                                  ? {'carModel': _customController.text}
                                  : type == 'SaleStatus'
                                      ? {'SaleStatus': _customController.text}
                                      : {'Location': _customController.text});
                          Navigator.pop(context);
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

  Widget textfield({
    @required String hintText,
    String type,
  }) {
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
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                padding: EdgeInsets.only(
                    /* left: type == "SaleStatus"
                        ? MediaQuery.of(this.context).size.width / 1.5
                        : MediaQuery.of(this.context).size.width / 1.25,*/
                    top: 10),
                child: type == "SaleStatus"
                    ? Container(
                        width: MediaQuery.of(this.context).size.width / 4,
                        height: 30,
                        child: (nUser == null)
                            ? ToggleSwitch(
                                minWidth:
                                    MediaQuery.of(this.context).size.width /
                                        8.5,
                                initialLabelIndex:
                                    carList[carIndex].salestatus ? 0 : 1,
                                cornerRadius: 20.0,
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.white,
                                labels: ['Y', 'N'],
                                activeBgColors: [Colors.blue, Colors.pink],
                                onToggle: (index) {
                                  setState(() {
                                    carList[carIndex].salestatus =
                                        !carList[carIndex].salestatus;
                                  });
                                  update.updateData(user_id, {
                                    'SaleStatus': carList[carIndex].salestatus
                                  });
                                },
                              )
                            : null,
                      )
                    : (nUser == null)
                        ? IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              createAlertDialog(this.context, type, hintText);
                            },
                          )
                        : null,
              )
            ])
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (prog == false) {
      if (carList.isEmpty) {
        err = true;
      }
      if (nUser == null) {
        user_id = FirebaseAuth.instance.currentUser.uid;
      } else {
        user_id = nUser;
      }
      carIndex = carList.indexWhere((element) => element.id == user_id);
      /*try {
        ref = FirebaseStorage.instance
            .ref()
            .child(carList[carIndex].carprofileImage);
        ref.getDownloadURL().then((loc) {
          setState(() {
            _imageUrl = loc;
          });
        });
      } catch (error) {
        _imageUrl = null;
      }*/
    }
    carList = Provider.of<Carprovider>(this.context, listen: true).car;
    Future getImage() async {
      var image = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 600);
      setState(() {
        uImage = image;
      });
      String filename = "car" + user_id + '.png';
      _imageUrl = '';
      var firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
      var uploadTask = firebaseStorageRef.putFile(uImage).then((loc) {
        update.updateData(user_id, {'CarProfileImage': filename});
      });
    }

    return err
        ? Scaffold(
            body: new AlertDialog(
              title: new Text('Error'),
              content: new Text('Error while fetching data!'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Exit'),
                ),
              ],
            ),
          )
        : Scaffold(
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
            body: prog
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 5),
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  image: _imageUrl != null
                                                      ? uImage == null
                                                          ? NetworkImage(
                                                              _imageUrl)
                                                          : FileImage(uImage)
                                                      : AssetImage(
                                                          "images/istockphoto-1144092062-612x612.jpg"))),
                                        ),
                                        (nUser == null)
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        6.2,
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2.2),
                                                margin:
                                                    EdgeInsets.only(bottom: 50),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.black54,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      getImage();
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Text(''),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      textfield(
                                          hintText: carList[carIndex].carmodel,
                                          type: "carModel"),
                                      textfield(
                                          hintText: (nUser == null)
                                              ? "For Sale"
                                              : carList[carIndex].salestatus
                                                  ? "Car is listed for sale."
                                                  : "Car is not Listed for sale",
                                          type: "SaleStatus"),
                                      textfield(
                                          hintText: carList[carIndex].location,
                                          type: "Location"),
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
