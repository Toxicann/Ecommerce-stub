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
          title: const Text('E-Commerce App'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              // const Text('Welcome to Flutter'),
              // const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                child: ElevatedButton(
                  child:
                      Text(user == null ? 'Sign In with Google' : 'Sign Out'),
                  onPressed: () async {
                    user == null
                        ? await _googleSignIn.signIn()
                        : await _googleSignIn.signOut();
                    setState(() {});

                    if (user!=null){
                      Navigator.pushNamed(context, '/main');
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
