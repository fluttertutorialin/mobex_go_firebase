import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/utils/vars.dart';
import 'collectmobile/tab_collectmobile.dart';
import 'login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  createState() => new _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Duration five;
  Timer t2;
  String routeName;

  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();

    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.getLoginDetails();

    five = const Duration(seconds: 3);
    t2 = new Timer(five, () {
      _loginGo();
    });
  }

  @override
  void dispose() {
    if (this.mounted) super.dispose();
    t2.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        /*LoginBackground(
          showIcon: true,
        ),*/
        Container(
            height: double.infinity,
            width: double.infinity,
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Image.asset(
                        "assets/images/mobex_go.png"
                      ))
                ]))
      ]),
      /*bottomNavigationBar: new Container(
          width: MediaQuery.of(context).size.width, child: appLaunchDetail()),*/
    );
  }

  appLaunchDetail() => Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(appUpDateDate,
                style: TextStyle(fontFamily: quickFont,
                    color: Colors.black45,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold)),
          ]));

  _loginGo() {
    _userBloc.currentState.isLogin == true
        ? Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new TabCollectMobile(id: 0)))
        : Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new LoginPage()));
  }
}
