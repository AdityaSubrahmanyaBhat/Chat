import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/welcome_screen.dart';
import 'package:chat/services/auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  static String id = '/wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authService.authStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.data != null) {
          return ChatScreen();
        } else {
          return WelcomeScreen();
        }
      },
    );
  }
}
