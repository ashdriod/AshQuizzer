import 'package:classmate/helper/functions.dart';
import 'package:classmate/services/auth.dart';
import 'package:classmate/views/home.dart';
import 'package:classmate/views/signin.dart';
import 'package:classmate/widget/widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  String email, password, name;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  signUp() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .signUpWithEmailAndPassword(email, password)
          .then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });

          Constants.saveUserLoggedInSharedPreference(true);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formkey,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Spacer(),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "Enter Your Name" : null;
                        },
                        decoration: InputDecoration(hintText: "Name"),
                        onChanged: (val) {
                          name = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty
                              ? "Enter Correct Email Address"
                              : null;
                        },
                        decoration: InputDecoration(hintText: "Email"),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          return val.isEmpty ? "Enter Password Please" : null;
                        },
                        decoration: InputDecoration(hintText: "Password"),
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          signUp();
                        },
                        child: blueButton(context, "Sign Up"),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account ?",
                            style: TextStyle(fontSize: 15.5),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SiginIn(),
                                    ));
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 15.5,
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  )),
            ),
    );
  }
}
