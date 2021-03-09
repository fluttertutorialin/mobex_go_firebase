import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/bloc/user/user_state.dart';
import 'package:mobex_go/ui/cliper/drawer_cliper.dart';
import 'package:mobex_go/utils/vars.dart';

import 'profile_tile.dart';

class CommonDrawer extends StatefulWidget {
  @override
  CommonDrawerState createState() => CommonDrawerState();
}

class CommonDrawerState extends State<CommonDrawer> {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();

    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.getLoginDetails();
  }

  @override
  Widget build(BuildContext context) =>
      Stack(overflow: Overflow.visible, children: <Widget>[
        ClipPath(
            clipper: CustomDrawerClipper(),
            child: Material(
                child: Stack(children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                    BlocBuilder(
                        bloc: _userBloc,
                        builder: (context, UserState snapshot) =>
                            UserAccountsDrawerHeader(
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                ),
                                accountName: Row(children: <Widget>[
                                  Icon(
                                    Icons.account_circle,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                      StringUtils.capitalize(snapshot.userName),
                                      style: TextStyle(
                                          fontFamily: quickFont,
                                          fontSize: 18.0,
                                          color: Colors.black))
                                ]),
                                accountEmail: Row(children: <Widget>[
                                  Icon(Icons.phone_android,
                                      color: Colors.grey, size: 20),
                                  SizedBox(width: 3),
                                  Text(snapshot.mobile,
                                      style: TextStyle(
                                          fontFamily: quickFont,
                                          fontSize: 14.0,
                                          color: Colors.black))
                                ]),
                                currentAccountPicture: CircleAvatar(
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.1),
                                    backgroundImage:
                                        ExactAssetImage(imageProfile)))),
                    CustomListView(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        name: drawerHome,
                        leading: Icon(Icons.home, color: Colors.blue)),
                    CustomListView(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, profileRoute);
                        },
                        name: drawerProfile,
                        leading: Icon(Icons.person, color: Colors.green)),
                    CustomListView(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        name: drawerDashboard,
                        leading: Icon(Icons.dashboard, color: Colors.brown)),
                    CustomListView(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, contactRoute);
                        },
                        name: drawerContactUs,
                        leading: Icon(Icons.contacts, color: Colors.cyan)),
                    Divider(color: Colors.orangeAccent),
                    CustomListView(
                        onPressed: () {
                          _userBloc.saveUserName('');
                          _userBloc.saveId('');
                          _userBloc.saveMobile('');
                          _userBloc.saveIsLogin(false);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              loginRoute, (Route<dynamic> route) => false);
                        },
                        name: drawerLogout,
                        leading: Icon(Icons.vpn_key, color: Colors.red)),
                    Divider(color: Colors.orangeAccent),
                  ]))
            ]))),
        FractionalTranslation(
            translation: Offset(-0.24, 0.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Material(
                        elevation: 9.0,
                        type: MaterialType.circle,
                        color: Colors.transparent,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30.0,
                        )))))
      ]);

  goToLogoutDialog() => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                successLogout(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.clear,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ])
              ]))));

  successLogout() => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ProfileTile(
                      title: titleLogout,
                      textColor: Colors.black,
                      subtitle: labelSureLogout,
                    ),
                    ListTile(
                        title: Text(labelUserName,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: quickFont,
                                fontWeight: FontWeight.normal)),
                        subtitle: Text(labelLoginDateTime,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: quickFont,
                                fontWeight: FontWeight.normal)),
                        trailing: CircleAvatar(
                            radius: 20.0,
                            backgroundImage: ExactAssetImage(
                                'assets/images/user_profile.png'))),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 30.0),
                        width: double.infinity,
                        child: RaisedButton(
                            elevation: 0.0,
                            splashColor: Colors.redAccent,
                            padding: EdgeInsets.all(12.0),
                            shape: StadiumBorder(),
                            child: Text(
                              btnLogout,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontFamily: quickFont),
                            ),
                            color: Colors.red,
                            onPressed: () {
                              _userBloc.saveUserName('');
                              _userBloc.saveId('');
                              _userBloc.saveMobile('');
                              _userBloc.saveIsLogin(false);

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  loginRoute, (Route<dynamic> route) => false);
                            })),
                  ]))));
}

class CustomListView extends StatelessWidget {
  CustomListView(
      {@required this.onPressed, @required this.name, @required this.leading});

  final GestureTapCallback onPressed;
  final String name;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          name,
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w300,
              fontFamily: quickFont,
              fontSize: 16.0),
        ),
        leading: leading,
        onTap: onPressed);
  }
}
