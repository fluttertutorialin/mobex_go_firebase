import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/postpone/postpone_bloc.dart';
import 'package:mobex_go/bloc/postpone/postpone_state.dart';
import 'package:mobex_go/model/postpone/postpone_response.dart';
import 'package:mobex_go/utils/vars.dart';
import 'delivery_row.dart';

class TabPostPonePage extends StatefulWidget {
  final String userId;

  TabPostPonePage(this.userId);

  @override
  _TabPostPonePageState createState() => _TabPostPonePageState();
}

class _TabPostPonePageState extends State<TabPostPonePage> {
  PostPoneBloc _postPoneBloc;

  @override
  void initState() {
    super.initState();

    _postPoneBloc = BlocProvider.of<PostPoneBloc>(context);
    _postPoneBloc.userIdParam(widget.userId);
  }

  _bodyData() => BlocBuilder(
      bloc: _postPoneBloc,
      builder: (context, PostPoneState snapshot) => snapshot.loading
          ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorProgressBar)),
            )
          : _bodyList(snapshot.postPoneList, snapshot.errorMessage));

  _bodyList(List<PostPoneResponse> postPoneList, String errorMessage) =>
      postPoneList.isEmpty
          ? ListView( physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 300,
                          child: FlareActor(
                              errorMessage == 'No internet'
                                  ? 'assets/flare/no_internet.flr'
                                  : 'assets/flare/empty.flr',
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: errorMessage == 'No internet'
                                  ? "Untitled"
                                  : null),
                        )
                      ]))
            ])
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemCount: postPoneList.length,
              itemBuilder: (context, position) {
                var postPone = postPoneList[position];
                return Card(
                    color: Theme.of(context).cardColor,
                    //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10.0),
                          top: Radius.circular(2.0)),
                    ),
                    child: DeliveryRow(
                        postPone.refNo.toString(),
                        postPone.endCustomer,
                        postPone.brand,
                        postPone.contactNo,
                        postPone.fullAddress,
                        postPone.model,
                        postPone.assignTime,
                        amount: postPone.codAmount.toString(),
                        reason: postPone.postponedReason,
                        deliveryType: postPone.description));
              });

  @override
  void dispose() {
    if (this.mounted) super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _bodyData());
}
