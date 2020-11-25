import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  static String id='chatlistscreen';
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
//  List chatlist=[];
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    getchats();
//  }
//
//  void getchats()async{
//    await for(var user in FirebaseUser )
//      chatlist.add(user);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        centerTitle: true,
      ),
//      body:ListView(
//        children: chatlist,
//      ),
    );
  }
}
