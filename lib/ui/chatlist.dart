import 'package:Dcode/ui/privateChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(chatlist());

// #docregion MyApp
class chatlist extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chats',
      home: UserList(),
    );
  }
// #enddocregion build
}
// #enddocregion MyApp

// #docregion RWS-var
class UserListState extends State<UserList> {
  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildChatList() {
    var imageUrl;
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.active) {
          var courseDocument = snapshot.data.data;
          var sections = courseDocument()['chatlist'];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: /*1*/ (context, index) {
              // imageUrl = loadAsset(sections[index]['imagepath']);

              // try {
              //   var ref = await FirebaseStorage.instance
              //       .ref()
              //       .child(sections[index]['imagepath']);
              //   ref.getDownloadURL().then((loc) {
              //     imageUrl = loc;
              //     log(imageUrl);
              //   });
              // } catch (error) {
              //   imageUrl = null;
              // }
              // var firebaseStorageRef = FirebaseStorage.instance
              //     .ref()
              //     .child(sections[index]['imagepath']);
              imageUrl =
                  "https://firebasestorage.googleapis.com/v0/b/dcode-bd3d1.appspot.com/o/user" +
                      sections[index]['userid'] +
                      ".png?alt=media";
              return ListTile(
                leading: CircleAvatar(
                  child: Row(
                    children: <Widget>[
                      (imageUrl == null)
                          ? Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('images/user.png'),
                                    fit: BoxFit.fill),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                title: Text(
                  sections[index]['username'],
                  style: _biggerFont,
                ),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  // send to chat screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              user: {
                                "username": sections[index]['username'],
                                "imagepath": imageUrl,
                                "userid": sections[index]['userid']
                              },
                            )),
                  );
                },
              );
              ;
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: sections.runtimeType.toString() == "List<dynamic>"
                ? sections.length
                : 0,
          );
        } else {
          return Container();
        }
      },
    );
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow

  // #enddocregion _buildRow

  // #docregion RWS-build

  // String loadAsset(String imagepath) {
  //   var imageUrl;
  //   try {
  //     var ref = FirebaseStorage.instance.ref().child(imagepath);
  //     ref.getDownloadURL().then((loc) {
  //       imageUrl = loc;
  //     });
  //   } catch (error) {
  //     imageUrl = null;
  //   }

  //   return imageUrl;
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context); // avoid app from exiting
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('Chats '),
              Image.asset(
                'images/chat.png',
                height: 40,
              ),
            ],
          ),
          backgroundColor: c1,
        ),
        backgroundColor: Colors.white,
        body: _buildChatList(),
      ),
    );
  }
// #enddocregion RWS-build
// #docregion RWS-var

}

// #enddocregion RWS-var
class UserList extends StatefulWidget {
  @override
  UserListState createState() => new UserListState();
}
