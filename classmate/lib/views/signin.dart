import 'package:classmate/helper/functions.dart';
import 'package:classmate/services/auth.dart';
import 'package:classmate/views/home.dart';
import 'package:classmate/views/signup.dart';
import 'package:classmate/widget/widgets.dart';
import 'package:flutter/material.dart';

class SiginIn extends StatefulWidget {
  @override
  _SiginInState createState() => _SiginInState();
}

class _SiginInState extends State<SiginIn> {
  final _formkey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  signIn() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signInEmailAndPass(email, password).then((val) {
        if (val != null) {
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
                          signIn();
                        },
                        child: blueButton(context, "Sign In"),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an Account ?",
                            style: TextStyle(fontSize: 15.5),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(
                                "Sign Up",
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
