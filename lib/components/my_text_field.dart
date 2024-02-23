import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget{
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode?focusNode;
  const MyTextField({super.key,
  required this.hintText,
  required this.obscureText,
  required this.controller,
  this.focusNode});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}