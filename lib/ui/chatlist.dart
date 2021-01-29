import 'package:Dcode/logic/chatlist.dart';
import 'package:Dcode/ui/privateChat.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'notification.dart';
import 'profile.dart';

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
  final chatlistNames chatlistLogic = chatlistNames();

  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildChatList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        return _buildRow(chatlistLogic.getNames()[i]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: chatlistLogic.getNames().length,
    );
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(String name) {
    return ListTile(
      leading: CircleAvatar(
        child: Row(
          children: <Widget>[
            Image.asset(
              'images/user.png',
              height: 40,
            ),
          ],
        ),
      ),
      title: Text(
        name,
        style: _biggerFont,
      ),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        // send to chat screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => privateChat()),
        );
      },
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(Icons.chat),
          backgroundColor: Colors.lightBlue,
        ),
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
