import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:module8/components/my_button.dart';
import 'package:module8/components/my_text_field.dart';
import 'package:module8/services/auth/auth_service.dart';
import 'package:provider/provider.dart';
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key,required this.onTap,});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  void signUp()async{
    final service = Provider.of<AuthService>(context,listen: false);

    if(passwordController.text == confirmPasswordController.text){
    try{
      await service.signUPwithemailandpassword(controller.text, passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }}else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords don't match")));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // logo
              SizedBox(height: 100,),
              Text("To do",style: TextStyle(color: CupertinoColors.activeGreen,fontWeight: FontWeight.w900,fontSize: 40),),
              SizedBox(height: 30,),
              // email
              MyTextField(controller: controller, hint: 'Email', isPassword: false),
              SizedBox(height: 20,),
          
              // password
              MyTextField(controller: passwordController, hint: "Password", isPassword: true),
              SizedBox(height: 20,),
          
              // confirm password
              MyTextField(controller: confirmPasswordController, hint: "Confirm Password", isPassword: true),
              SizedBox(height: 30,),
          
              // sign in button
              MyButton(name: 'Sign Up',onTap: signUp,),
              SizedBox(height: 50,),
          
              // register or login page
              GestureDetector(
                onTap: widget.onTap,
                child: Text("Login",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: 50,)
            ],),
        ),
      ),
    );
  }
}
