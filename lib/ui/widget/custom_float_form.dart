import 'package:flutter/material.dart';
import 'package:mobex_go/utils/vars.dart';

class CustomFloatForm extends StatelessWidget {
  final IconData icon;
  final VoidCallback qrCallback;
  final isMini;

  CustomFloatForm({this.icon, this.qrCallback, this.isMini = false});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      mini: isMini,
      onPressed: qrCallback,
      child: Ink(
          decoration:  BoxDecoration(
              gradient:  LinearGradient(colors: gradientsButton)),
          child: Stack(fit: StackFit.expand, children: <Widget>[
            Icon(
              icon,
              size: 30,
              color: Colors.black
            )
          ])));
}
