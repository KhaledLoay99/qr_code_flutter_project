import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chats',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: UserList(),
    );
  }
// #enddocregion build
}
// #enddocregion MyApp

// #docregion RWS-var
class UserListState extends State<UserList> {
  final _chats = ['ahmed', 'mohamed', "zizo"];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildChatList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        return _buildRow(_chats[i]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: _chats.length,
    );
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(String name) {
    return ListTile(
      title: Text(
        name,
        style: _biggerFont,
      ),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        // send to chat screen
      },
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: _buildChatList(),
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
