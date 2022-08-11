import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
   AppContainer({required this.child,this.borderRadius = 0.0, this.padding = 0, this.shadow =0.0, Key? key}) : super(key: key);
 Widget child;

  double borderRadius, shadow;
  double padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: shadow,
              blurRadius: 3,
              offset: const Offset(1, 3), // changes position of shadow
            ),
          ]
      ),
      // c/
      child:   child,
    );
  }
}
