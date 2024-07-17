import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  const MyButton({super.key, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue
        ),
        child: Text(name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),),
      ),
    );
  }
}
