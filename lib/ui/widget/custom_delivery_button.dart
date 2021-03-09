import 'package:mobex_go/utils/vars.dart';
import 'package:flutter/material.dart';

class CustomDeliveryButton extends StatelessWidget {
  final Color textColor;
  final String btnName;
  final VoidCallback qrCallback;

  CustomDeliveryButton({this.textColor, this.btnName, this.qrCallback});

  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.all(3), child: _placeContainer(btnName, textColor));

  buttonTextStyle(String btnName, Color color) => Text(btnName,
      style: TextStyle(
          fontSize: 10.0,
          letterSpacing: 0.1,
          fontFamily: ralewayFont,
          color: color));

  Widget _placeContainer(String title, Color color) => Ink(
     decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(8),
         color: color.withOpacity(0.2)),
      child: GestureDetector(child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[buttonTextStyle(title, color)])),
      onTap: qrCallback));
}
