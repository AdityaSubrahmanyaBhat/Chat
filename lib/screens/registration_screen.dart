import 'package:chat/constants/consts.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/services/auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool loading = false;
  AuthService _authService = AuthService();
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                height: 20.0,
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
                      padding: EdgeInsets.symmetric(horizontal: 44.0),
                      child: TextFormField(
                        onChanged: (val) {
                          //email.text = val;
                        },
                        controller: email,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: false,
                        decoration: inputDecoration.copyWith(hintText: 'Email'),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 44.0),
                      child: TextFormField(
                        onChanged: (val) {
                          // password.text = val;
                        },
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration:
                            inputDecoration.copyWith(hintText: 'Password'),
                      ),
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
                        child: Text('Register'),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            final newUser = await _authService.register(
                                email.text, password.text);
                            if (newUser != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.lightGreenAccent[400],
                                  content: Text(
                                    'Registration successful',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                              Duration(seconds: 2);
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              loading = false;
                            });
                          } catch (e) {
                            print(e);
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
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
