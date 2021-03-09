import 'package:mobex_go/bloc/ascho/ascho_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'common_drawer.dart';
import 'custom_float_form.dart';

class CommonScaffold extends StatelessWidget {
  final appTitle;
  final showAppBar;
  final Widget bodyData;
  final showDrawer;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final Widget bottomData;
  final bool showBottom;
  final elevation;

  CommonScaffold(
      {this.appTitle,
      this.bodyData,
      this.showDrawer = false,
      this.backGroundColor,
      this.actionFirstIcon = Icons.refresh,
      this.scaffoldKey,
      this.bottomData,
        this.showAppBar = true,
      this.showBottom = false,
      this.elevation = 0.8});

  Widget myBottomBar() => BottomAppBar(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      shape: CircularNotchedRectangle(),
      child: Ink(
          height: 50.0,
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: kitGradients)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: double.infinity,
                    child: InkWell(
                        radius: 15.0,
                        splashColor: Colors.white,
                        onTap: () {},
                        child: Center(
                            child: Text(
                          '$labelASC',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )))),
                SizedBox(
                  width: 20.0,
                ),
                SizedBox(
                    height: double.infinity,
                    child: InkWell(
                        onTap: () async {
                          String url = '$companyWebsiteUrl';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        radius: 15.0,
                        splashColor: Colors.white,
                        child: Center(
                            child: Text(
                          '$labelHO',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))))
              ])));

  @override
  Widget build(BuildContext context) => Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: backGroundColor != null ? backGroundColor : null,
      appBar: showAppBar ? AppBar(
          brightness: Brightness.light,
          leading: showDrawer
              ? GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    child: Image.asset('assets/images/mobex_go.png',
                        height: 30, color: Colors.deepOrange.shade200),
                  ))
              : null,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: elevation,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          backgroundColor: Colors.grey.shade50,
          title: Text(appTitle,
              style: TextStyle(
                  fontFamily: quickFont, fontSize: 18.0, color: Colors.black87)),
          /*actions: _buildAppActions(),*/
          actions: <Widget>[
            IconButton(
              onPressed: () {
                AscHoBloc _ascHoBloc = BlocProvider.of<AscHoBloc>(context);
                if (!_ascHoBloc.currentState.loading) {
                  _ascHoBloc.ascHo(_ascHoBloc.currentState.userId);
                }
              },
              icon: Icon(actionFirstIcon),
            )
          ]) : null,
      drawer: showDrawer ? CommonDrawer() : null,
      body: bodyData,
      bottomNavigationBar: showBottom ? bottomData : null);

  /*List<Widget> _buildAppActions() {
    return [
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 1,
              child: Text(
                "Name",
                style: TextStyle(color: Colors.black, fontFamily: quickFont),
              )),
          PopupMenuItem(
              value: 2,
              child: Text(
                "Inquiry No.",
                style: TextStyle(color: Colors.black, fontFamily: quickFont),
              )),
          PopupMenuItem(
              value: 3,
              child: Text(
                "Date",
                style: TextStyle(color: Colors.black, fontFamily: quickFont),
              ))
        ],
        icon: Icon(Icons.search),
        offset: Offset(0, 100),
      )
    ];
  }*/
}
