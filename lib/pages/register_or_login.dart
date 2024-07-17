import 'package:flutter/material.dart';
import 'package:module8/pages/login_page.dart';
import 'package:module8/pages/register_page.dart';
class RegisterOrLogin extends StatefulWidget {
  const RegisterOrLogin({super.key});

  @override
  State<RegisterOrLogin> createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {
  bool showLoginPage = true;
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglePages,);
    }else{
      return RegisterPage(onTap: togglePages,);
    }
  }
}
