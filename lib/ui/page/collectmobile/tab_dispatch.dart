import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mobex_go/utils/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/dispatch/dispatch_bloc.dart';
import 'package:mobex_go/bloc/dispatch/dispatch_state.dart';
import 'package:mobex_go/bloc/submitundelivered/submit_undelivered_bloc.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';
import 'package:mobex_go/service/network_service_response.dart';
import 'package:mobex_go/ui/widget/custom_delivery_button.dart';
import 'package:mobex_go/ui/widget/profile_tile.dart';
import 'package:mobex_go/utils/vars.dart';
import 'delivery_row.dart';
import 'postpone_cancel_reason.dart';
import 'postpone_undelivered_reason.dart';

class TabDispatchPage extends StatefulWidget {
  final String userId;
  final bool submitMobile = false;
  TabDispatchPage(this.userId);

  @override
  _TabDispatchPageState createState() => _TabDispatchPageState();
}

class _TabDispatchPageState extends State<TabDispatchPage> {
  DispatchBloc _dispatchBloc;
  SubmitUndeliveredBloc _submitUndeliveredBloc;

  @override
  void initState() {
    super.initState();

    _dispatchBloc = BlocProvider.of<DispatchBloc>(context);
    _submitUndeliveredBloc = BlocProvider.of<SubmitUndeliveredBloc>(context);

    _dispatchBloc.userIdParam(widget.userId);
  }

  @override
  void dispose() {
    if (this.mounted) super.dispose();
  }

  _bodyData() => BlocBuilder(
      bloc: _dispatchBloc,
      builder: (context, DispatchState snapshot) => snapshot.loading
          ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorProgressBar)),
            )
          : _bodyList(snapshot.dispatchList, snapshot.errorMessage));

  _bodyList(List<DispatchResponse> dispatchList, String errorMessage) =>
      dispatchList.isEmpty
          ? ListView( physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0), children: <Widget>[
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
              itemCount: dispatchList.length,
              itemBuilder: (context, position) => Card(
                  color: Theme.of(context).cardColor,
                  shape:
                      RoundedRectangleBorder //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder select any oneL̥
                          (
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10.0),
                        top: Radius.circular(2.0)),
                  ),
                  child: Column(children: <Widget>[
                    DeliveryRow(
                        dispatchList[position].jobId.toString(),
                        dispatchList[position].name,
                        dispatchList[position].brand,
                        dispatchList[position].mobile,
                        dispatchList[position].address,
                        dispatchList[position].model,
                        dispatchList[position].dispatchDateTime,
                        amount: dispatchList[position].codAmount.toString(),
                        submitStatus: dispatchList[position].dispatchMobile),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomDeliveryButton(
                              textColor: Colors.green,
                              btnName: btnDone,
                              qrCallback: () {
                                goToDoneDispatch(dispatchList[position],
                                    dispatchList[position].dispatchMobile);
                              }),
                          dispatchList[position].dispatchMobile
                              ? CustomDeliveryButton(
                                  textColor: Colors.brown,
                                  btnName: btnPostpone,
                                  qrCallback: () {
                                    _goPostPone(
                                        context, dispatchList[position]);
                                  })
                              : Container(),
                          dispatchList[position].dispatchMobile
                              ? CustomDeliveryButton(
                                  textColor: Colors.red,
                                  btnName: btnUndelivered,
                                  qrCallback: () {
                                    _goUndelivered(dispatchList[position]);
                                  })
                              : Container(),
                        ])
                  ])));

  goToDoneDispatch(DispatchResponse dispatchResponse, bool submitMobile) =>
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => Center(
                  child: SingleChildScrollView(
                      child: Stack(children: <Widget>[
                Column(children: <Widget>[
                  doneDispatch(dispatchResponse),
                  FloatingActionButton.extended(
                      elevation: 4.0,
                      backgroundColor: Colors.white,
                      icon: Icon(
                          submitMobile
                              ? dispatchResponse.lonerPhone == 0
                                  ? Icons.block
                                  : Icons.phone_android
                              : Icons.airline_seat_recline_extra,
                          color: submitMobile
                              ? dispatchResponse.lonerPhone == 0
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.orangeAccent.withOpacity(0.5)
                              : Colors.blueAccent.withOpacity(0.5)),
                      label: Text(
                          submitMobile
                              ? dispatchResponse.lonerPhone == 0
                                  ? labelNoLoaner
                                  : labelLoaner
                              : labelHo,
                          style: TextStyle(
                              fontFamily: quickFont,
                              fontSize: 15.0,
                              color: submitMobile
                                  ? dispatchResponse.lonerPhone == 0
                                      ? Colors.red
                                      : Colors.orangeAccent
                                  : Colors.blueAccent,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        List<String> dateTimeList = getDateTime();

                        var param = {
                          jobIdParam: dispatchResponse.jobId,
                          collectLoanerPhoneParam:
                              dispatchResponse.lonerPhone == 1
                                  ? loanerGiveCustomerType
                                  : loanerNotGiveCustomerType,
                          dispatchDoneDateParam: dateTimeList[0],
                          dispatchDoneTimeParam: dateTimeList[1].toUpperCase(),
                          dispatchMobileParam: dispatchResponse.dispatchMobile
                        };

                        _submitUndeliveredBloc.title(tabDispatch);
                        _submitUndeliveredBloc.reasonTitle(btnDone);
                        _submitUndeliveredBloc.mapParam(param);
                        _submitDone(dispatchResponse.jobId);
                      })
                ]),
                Container(
                    margin:
                        EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                              width: 30.0,
                              height: 30.0,
                              child: FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 20.0,
                                  ),
                                  onPressed: () => Navigator.pop(context)))
                        ]))
              ]))));

  _submitDone(String jobId) {
    showProgress(context);
    _submitUndeliveredBloc.submit((results) {
      if (results is NetworkServiceResponse) {
        hideProgress(context);
        var apiResponse = results;
        if (apiResponse.responseCode == ok200) {
          _dispatchBloc.jobIdRemove(jobId);
          Navigator.pop(context);
        }
      } else {
        NetworkServiceResponse apiResponse = results;
        toast(context, apiResponse.errorMessage);
        hideProgress(context);
      }
    });
  }

  doneDispatch(DispatchResponse dispatchResponse) => Container(
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
                        title: tabDispatch,
                        textColor: Colors.black,
                        subtitle: msgDoneDispatch),
                    ListTile(
                        title: Text(labelName,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: quickFont,
                                fontWeight: FontWeight.normal)),
                        subtitle: Text(dispatchResponse.name,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: quickFont,
                                fontWeight: FontWeight.normal)))
                  ]))));

  _goUndelivered(DispatchResponse dispatchResponse) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostPoneUndeliveredReasonPage(
              title: tabDispatch,
              reasonName: btnUndelivered,
              dispatchResponse: dispatchResponse)),
    );
  }

  _goPostPone(BuildContext context, DispatchResponse dispatchResponse) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostPoneCancelReasonPage(
              title: tabDispatch,
              reasonName: btnPostpone,
              dispatchResponse: dispatchResponse)),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _bodyData());
}
