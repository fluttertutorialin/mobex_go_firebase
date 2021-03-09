import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobex_go/ui/cliper/arc_clipper.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/utils/vars.dart';
import 'contact_widget.dart';

class ContactPage extends StatelessWidget {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  Widget bodyData() => ListView(physics: ScrollPhysics(), children: <Widget>[
            Stack(children: <Widget>[
          /*    ClipPath(
                  clipper: ArcClipper(),
                  child: Container(
                      height: 185.0,
                      child: Stack(children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                          colors: gradientsClipper,
                        ))),
                        Center(
                          child: Text(companyName,
                              style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: quickFont,
                                  color: Colors.black45)),
                        )
                      ]))),*/
              Column(children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                ContactWidget()
              ])
            ])


      ]);

  @override
  Widget build(BuildContext context) => _scaffold();

  Widget _scaffold() => CommonScaffold(
        backGroundColor: Colors.grey.shade100,
        actionFirstIcon: null,
        appTitle: titleContactUs,
        showDrawer: false,
        scaffoldKey: _scaffoldState,
        bodyData: bodyData(),
      );
}
