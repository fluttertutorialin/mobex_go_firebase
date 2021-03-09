import 'package:flutter/material.dart';
import 'package:mobex_go/utils/vars.dart';

class CustomFloat extends StatelessWidget {
  final IconData icon;
  final Widget builder;
  final VoidCallback qrCallback;
  final isMini;

  CustomFloat({this.icon, this.builder, this.qrCallback, this.isMini = false});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        tooltip: 'Mobile Repair?',
        /*  shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.0), bottom: Radius.circular(5.0)),
      ),*/
        clipBehavior: Clip.antiAlias,
        mini: isMini,
        onPressed: qrCallback,
        child: Ink(
            decoration:  BoxDecoration(
                gradient:  LinearGradient(colors: kitGradients)),
            child: Stack(fit: StackFit.expand, children: <Widget>[
              Icon(
                icon,
                size: 30,
                color: Colors.orange,
              ),
              builder != null
                  ? Positioned(
                      right: 5.0,
                      top: 5.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: builder,
                        radius: 85.0,
                      ))
                  : Container()
            ])));

}
