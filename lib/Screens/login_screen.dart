import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'E-Commerce App (Signed ${user == null ? 'Out' : 'In'} )',
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(user == null
                      ? 'Sign In with Google'
                      : 'Sign Out from Google'),
                  onPressed: () async {
                    if (user == null) {
                      user = await _googleSignIn.signIn();
                      if (user != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, '/main');
                      }
                    } else {
                      user = await _googleSignIn.signOut();
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
