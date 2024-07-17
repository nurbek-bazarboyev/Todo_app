import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:module8/pages/home_page.dart';
import 'package:module8/pages/register_or_login.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return HomePage();
          }else{
            return RegisterOrLogin();
          }
        }
    );
  }
}
