import 'package:chat/constants/consts.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  bool loading = false;
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 0.0),
                margin: EdgeInsets.only(top: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100.0),
                    ),
                  ),
                  height: 300.0,
                ),
              ),
              Center(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 100.0,
                    child: Icon(
                      Icons.chat,
                      color: Colors.green,
                      size: 100.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44.0),
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration.copyWith(hintText: 'Email'),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 44.0),
                      child: TextFormField(
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration:
                              inputDecoration.copyWith(hintText: 'Password')),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              loading == false
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 44.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        child: Text("Log In"),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            final user =
                                _authService.login(email.text, password.text);
                            if (user != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.lightGreenAccent[400],
                                  content: Text(
                                    'Login successful',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              loading = false;
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  e,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                            print(e);
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                      ),
                    )
                  : Center(
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator()),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
