import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  const MyTextField({super.key, required this.controller, required this.hint, required this.isPassword});
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool show = true;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      obscureText: widget.isPassword ? show : false,
      controller: widget.controller,
      decoration: InputDecoration(
        label: Text(widget.hint),
       suffixIcon: widget.isPassword ? IconButton(onPressed: (){
         setState(() {
           show = !show;
         });
       }, icon: Icon(!show ? CupertinoIcons.eye : CupertinoIcons.eye_slash)) : null,
       focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)
        )
      ),
    );
  }
}
