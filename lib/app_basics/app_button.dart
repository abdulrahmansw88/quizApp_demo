import 'package:flutter/material.dart';
class AppButton extends StatelessWidget {
  AppButton({
    this.text,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);
  var text, height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.orange.shade800,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(1, 3), // changes position of shadow
          ),
         ]
      ),
      child:   Center(child:  Text(text, style: const TextStyle(color: Colors.white, fontSize: 18),)),
    );
  }
}