import 'package:mobex_go/utils/vars.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final title;
  final subtitle;
  final textColor;
  ProfileTile({this.title, this.subtitle, this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text(
          title,
          style: TextStyle(fontFamily: quickFont,
              fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          subtitle,
          style: TextStyle(fontFamily: quickFont,
              fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
        )
      ]);
}
