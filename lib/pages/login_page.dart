import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:module8/components/my_button.dart';
import 'package:module8/components/my_text_field.dart';
import 'package:module8/services/auth/auth_service.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void signIn()async{
    final service = Provider.of<AuthService>(context,listen: false);
    try{
     await service.signINwithemailandpassword(controller.text, passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // logo
              Text("To do",style: TextStyle(color: CupertinoColors.activeGreen,fontWeight: FontWeight.w900,fontSize: 40),),
              SizedBox(height: 30,),
              // email
              MyTextField(controller: controller, hint: 'Email', isPassword: false),
              SizedBox(height: 20,),

              // password
              MyTextField(controller: passwordController, hint: "Password", isPassword: true),
              SizedBox(height: 30,),

              // sign in button
              MyButton(name: 'Sign In',onTap: signIn,),
              SizedBox(height: 50,),

              // register or login page
              GestureDetector(
                onTap: widget.onTap,
                child: Text("Register",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: 50,)
          ],),
        ),
      ),
    );
  }
}
