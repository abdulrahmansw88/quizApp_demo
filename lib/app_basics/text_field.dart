import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
    AppTextField({
      Key? key,
       this.initialValue = "",
       this.hintText = "",
       this.labelText = "",
       this.enabled = true,
       this.obscureText = false,
       this.prefixIcon,
      this.keyboardType,
      this.maxLines = 1,
      this.controller,
      this.suffixIcon,
      this.border = false,
  }) : super(key: key);
     final String initialValue , hintText,labelText;
    var  prefixIcon;
    var keyboardType;
    final int maxLines;
   final bool border ;
   final bool obscureText;
   final bool enabled;
    var controller;
   var suffixIcon;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      // initialValue: initialValue,
      obscureText: obscureText,
  enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: border == true ? OutlineInputBorder(
         borderRadius :BorderRadius.circular(15.0),
        ): null,
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      // readOnly: enabled,
    );
  }
}