import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/bloc/user/user_state.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/utils/vars.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();

    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.getLoginDetails();
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  bodyData() => SafeArea(
      child: Container(
          child: BlocBuilder(
              bloc: _userBloc,
              builder: (context, UserState snapshot) {
                return Stack(children: <Widget>[
                  Container(
                    height: 320.0,
                    width: double.infinity,
                  ),
                  Container(
                      height: 200.0,
                      width: double.infinity,
                      child: snapshot.userPhoto == null
                          ? DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1)))
                          : DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter: new ColorFilter.mode(
                                          Colors.black.withOpacity(0.2),
                                          BlendMode.dstATop),
                                      image: FileImage(snapshot.userPhoto))))),
                  Positioned(
                      top: 110.0,
                      left: 15.0,
                      right: 15.0,
                      child: Material(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20.0),
                                top: Radius.circular(2.0)),
                          ),
                          child: Container(
                            height: 150.0,
                            /*  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Colors.white),*/
                          ))),
                  Positioned(
                      top: 40.0,
                      left: (MediaQuery.of(context).size.width / 2 - 70.0),
                      child: Container(
                          child: new Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: new Stack(fit: StackFit.loose, children: <
                                Widget>[
                              new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Center(
                                        child: snapshot.userPhoto == null
                                            ? new CircleAvatar(
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.2),
                                                backgroundImage:
                                                    new ExactAssetImage(
                                                        imageProfile),
                                                radius: 65.0,
                                              )
                                            : new CircleAvatar(
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.2),
                                                backgroundImage: new FileImage(
                                                    snapshot.userPhoto),
                                                radius: 65.0,
                                              ))
                                  ]),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 90.0, left: 90.0),
                                  child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new FloatingActionButton(
                                          foregroundColor: Colors.grey,
                                          backgroundColor: Colors.white,
                                          onPressed: getImage,
                                          tooltip: 'Pick Image',
                                          child: Icon(Icons.add_a_photo),
                                        )
                                      ]))
                            ]))
                      ]))),
                  Positioned(
                      top: 195.0,
                      left: 15.0,
                      right: 15.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              snapshot.userName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.phone_android,
                                      color: Colors.black54, size: 20),
                                  Text(
                                    snapshot.mobile,
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 17.0,
                                        color: Colors.black54),
                                  )
                                ])
                          ]))
                ]);
              })));

  Widget _scaffold() => CommonScaffold(
        backGroundColor: Colors.grey.shade100,
        actionFirstIcon: null,
        appTitle: titleProfile,
        showDrawer: false,
        bodyData: bodyData(),
      );
}
