import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flare_flutter/flare_actor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_bloc.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_state.dart';
import 'package:mobex_go/model/imageupload/image_upload.dart';
import 'package:mobex_go/model/multiple_upload.dart';
import 'package:mobex_go/utils/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/pickup/pickup_bloc.dart';
import 'package:mobex_go/bloc/pickup/pickup_state.dart';
import 'package:mobex_go/bloc/submitundelivered/submit_undelivered_bloc.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/model/pickup/pickup_response.dart';
import 'package:mobex_go/service/network_service_response.dart';
import 'package:mobex_go/ui/widget/custom_delivery_button.dart';
import 'package:mobex_go/ui/widget/grouped_buttons_orientation.dart';
import 'package:mobex_go/ui/widget/profile_tile.dart';
import 'package:mobex_go/ui/widget/radio_button_group.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:uuid/uuid.dart';
import 'delivery_row.dart';
import 'postpone_cancel_reason.dart';

class TabPickUpPage extends StatefulWidget {
  final String userId;
  TabPickUpPage(this.userId);

  @override
  _TabPickUpPageState createState() => _TabPickUpPageState();
}

class _TabPickUpPageState extends State<TabPickUpPage> {
  PickUpBloc _pickUpBloc;

  @override
  void initState() {
    super.initState();

    _pickUpBloc = BlocProvider.of<PickUpBloc>(context);
    _pickUpBloc.userIdParam(widget.userId);
  }

  _bodyData() => BlocBuilder(
      bloc: _pickUpBloc,
      builder: (context, PickUpState snapshot) => snapshot.loading
          ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorProgressBar)),
            )
          : _bodyList(snapshot.pickUpList, snapshot.errorMessage));

  _bodyList(List<PickUpResponse> pickUpList, String errorMessage) => pickUpList
          .isEmpty
      ? ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          children: <Widget>[
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
          itemCount: pickUpList.length,
          itemBuilder: (context, position) => Card(
              color: Theme.of(context).cardColor,
              //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0), top: Radius.circular(2.0)),
              ),
              child: Container(
                  child: Column(children: <Widget>[
                DeliveryRow(
                    pickUpList[position].jobId,
                    pickUpList[position].name,
                    pickUpList[position].brand,
                    pickUpList[position].mobile,
                    pickUpList[position].address,
                    pickUpList[position].model,
                    pickUpList[position].pickUpDateTime),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CustomDeliveryButton(
                          textColor: Colors.green,
                          btnName: btnDone,
                          qrCallback: () {
                            showDialog(
                                context: context,
                                builder: (_) => DialogPickUpDone(
                                    pickUpResponse: pickUpList[position],
                                    position: position));
                          }),
                      CustomDeliveryButton(
                          textColor: Colors.brown,
                          btnName: btnPostpone,
                          qrCallback: () {
                            _navigateAndDisplayPostPoneCancel('$tabPickUp',
                                '$btnPostpone', pickUpList[position]);
                          }),
                      CustomDeliveryButton(
                          textColor: Colors.red,
                          btnName: btnCancel,
                          qrCallback: () {
                            _navigateAndDisplayPostPoneCancel('$tabPickUp',
                                '$btnCancel', pickUpList[position]);
                          })
                    ])
              ]))));

  _navigateAndDisplayPostPoneCancel(
      String title, String reason, PickUpResponse pickUpResponse) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostPoneCancelReasonPage(
              title: title,
              reasonName: reason,
              pickUpResponse: pickUpResponse)),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _bodyData());

  @override
  void dispose() {
    if (this.mounted) super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}

class DialogPickUpDone extends StatefulWidget {
  DialogPickUpDone(
      {Key key, this.pickUpResponse, this.position, this.pickUpBloc})
      : super(key: key);

  final PickUpResponse pickUpResponse;
  final int position;
  final PickUpBloc pickUpBloc;

  @override
  _DialogPickUpDoneState createState() => _DialogPickUpDoneState();
}

class _DialogPickUpDoneState extends State<DialogPickUpDone> {
  String selectOption;
  UserBloc _userBloc;
  SubmitUndeliveredBloc _submitUndeliveredBloc;
  PickUpBloc _pickUpBloc;
  MultipleUploadBloc _multipleUploadBloc;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _submitUndeliveredBloc = BlocProvider.of<SubmitUndeliveredBloc>(context);
    _pickUpBloc = BlocProvider.of<PickUpBloc>(context);

    _multipleUploadBloc = BlocProvider.of<MultipleUploadBloc>(context);
    _multipleUploadBloc.multipleUploadClear();
    _multipleUploadBloc
        .multipleUploadParam(MultipleUpload(file: null, uId: '0'));
    _userBloc.getLoginDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Center(
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
        Container(
            child: Stack(children: <Widget>[
          doneDispatch(widget.pickUpResponse),
          Container(
              margin: EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 0),
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
                            onPressed: () {
                              Navigator.pop(context);
                            }))
                  ]))
        ])),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton.extended(
                  elevation: 4.0,
                  backgroundColor: Colors.white,
                  icon: const Icon(Icons.block, color: Colors.red),
                  label: Text(
                    labelNoLoaner,
                    style: TextStyle(
                        fontFamily: quickFont,
                        fontSize: 15.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    _multipleUploadBloc.ascImageUpload((results) async {
                      if (results == null) {
                        toast(context, msgNotSelectPickUpMobileBoxPhoto);
                      } else if (selectOption == null) {
                        toast(context, msgRepairMobileAscHo);
                      } else {
                        showProgress(context);

                        _submitUndeliveredBloc.fileSelectedList(results);

                        _submitUndeliveredBloc
                            .firebaseUploadInsertDb((results) {
                          List<String> resultUrlList = results;

                          if (resultUrlList.isNotEmpty) {
                            List<String> dateTimeList = getDateTime();

                            List<ImageUpload> imageUpload = List();
                            for (var url in resultUrlList) {
                              /* TODO SPLIT IMAGE TYPE
                          List<String> urlSplitList =  url.split('_');
                          urlSplitList[1]
                           */
                              imageUpload.add(ImageUpload(image: url));
                            }

                            var param = {
                              assignToPlaceParam: selectOption,
                              inquiryNoParam: widget.pickUpResponse.inquiryNo,
                              isLoanerPhoneParam: loanerNotGiveCustomerType,
                              bikerIdParam: _userBloc.currentState.id,
                              bikerNameParam: _userBloc.currentState.userName,
                              imageParam: imageUpload,
                              imageTypeParam: customerReceiveImageType,
                              pickedUpdateParam: dateTimeList[0],
                              pickedTimeParam: dateTimeList[1].toString()
                            };

                            _submitUndeliveredBloc.title(tabPickUp);
                            _submitUndeliveredBloc.reasonTitle(btnDone);
                            _submitUndeliveredBloc.mapParam(param);

                            _submitDone(widget.pickUpResponse.inquiryNo);
                          } else {
                            hideProgress(context);
                          }
                        });
                      }
                    });
                  }),
              FloatingActionButton.extended(
                  elevation: 4.0,
                  backgroundColor: Colors.white,
                  icon: const Icon(Icons.phone_android, color: Colors.green),
                  label: Text(
                    labelLoaner,
                    style: TextStyle(
                        fontFamily: quickFont,
                        fontSize: 15.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    _multipleUploadBloc.ascImageUpload((results) {
                      if (results == null) {
                        toast(context, msgNotSelectPickUpMobileBoxPhoto);
                      } else if (selectOption == null) {
                        toast(context, msgRepairMobileAscHo);
                      } else {
                        showProgress(context);
                        _submitUndeliveredBloc.fileSelectedList(results);

                        _submitUndeliveredBloc
                            .firebaseUploadInsertDb((results) {
                          List<String> resultUrlList = results;

                          if (resultUrlList.isNotEmpty) {
                            List<String> dateTimeList = getDateTime();
                            List<ImageUpload> imageUpload = List();

                            for (var url in resultUrlList) {
                              imageUpload.add(ImageUpload(image: url));
                            }

                            var param = {
                              assignToPlaceParam: selectOption,
                              inquiryNoParam: widget.pickUpResponse.inquiryNo,
                              isLoanerPhoneParam: loanerGiveCustomerType,
                              imageTypeParam: customerReceiveImageType,
                              bikerIdParam: _userBloc.currentState.id,
                              bikerNameParam: _userBloc.currentState.userName,
                              imageParam: imageUpload,
                              pickedUpdateParam: dateTimeList[0],
                              pickedTimeParam: dateTimeList[1].toUpperCase()
                            };

                            _submitUndeliveredBloc.title(tabPickUp);
                            _submitUndeliveredBloc.reasonTitle(btnDone);
                            _submitUndeliveredBloc.mapParam(param);
                            _submitDone(widget.pickUpResponse.inquiryNo);
                          }
                        });
                      }
                    });
                  })
            ])
      ])));

  _submitDone(int inquiryNo) {
    _submitUndeliveredBloc.submit((results) {
      if (results is NetworkServiceResponse) {
        hideProgress(context);
        var apiResponse = results;

        if (apiResponse.responseCode == ok200) {
          _pickUpBloc.pickUpRemove(inquiryNo);
          Navigator.pop(context);
        } else {
          toast(context, msgPickUpNotSuccessful);
        }
      } else {
        hideProgress(context);
      }
    });
  }

  doneDispatch(PickUpResponse pickUp) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                ProfileTile(
                  title: pickUp.name,
                  textColor: Colors.black,
                  subtitle: msgDonePickUp,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  labelPickUpBoxPhoto,
                  style: TextStyle(
                      fontFamily: quickFont, fontSize: 15, color: Colors.grey),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    height: 100.0,
                    child: BlocBuilder(
                        bloc: _multipleUploadBloc,
                        builder: (context, MultipleUploadState snapshot) =>
                            ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.multipleUploadList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder:
                                    (BuildContext buildContext, int index) {
                                  return Container(
                                      padding: EdgeInsets.all(2),
                                      child: Stack(children: <Widget>[
                                        GestureDetector(
                                            child: Center(
                                                child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.1),
                                                    backgroundImage:
                                                        snapshot.multipleUploadList[index].uId ==
                                                                '0'
                                                            ? ExactAssetImage(
                                                                "assets/images/mobile_box_photo.png")
                                                            : FileImage(snapshot
                                                                .multipleUploadList[
                                                                    index]
                                                                .file),
                                                    child: CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.1),
                                                        foregroundColor:
                                                            Colors.black,
                                                        child: Text(snapshot.multipleUploadList[index].uId == '0' ? (snapshot.multipleUploadList.length - 1).toString() : (index + 1).toString(),
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 10))))),
                                            onTap: () {
                                              if (snapshot
                                                          .multipleUploadList[
                                                              index]
                                                          .uId ==
                                                      '0' &&
                                                  snapshot.multipleUploadList
                                                          .length <=
                                                      6) {
                                                Future<File> image = getImage(
                                                    ImageSource.camera);
                                                image.then((data) {
                                                  if (data != null) {
                                                    _multipleUploadBloc
                                                        .multipleUploadParam(
                                                            MultipleUpload(
                                                                uId:
                                                                    Uuid().v1(),
                                                                file: data,
                                                                imageType:
                                                                    customerReceiveImageType,
                                                                bikerId: _userBloc
                                                                    .currentState
                                                                    .id,
                                                                jobId: pickUp
                                                                    .jobId));

                                                    _scrollController.animateTo(
                                                        _scrollController
                                                                .offset +
                                                            snapshot
                                                                .multipleUploadList
                                                                .length,
                                                        curve: Curves.linear,
                                                        duration: Duration(
                                                            milliseconds: 500));
                                                  }
                                                }, onError: (e) {});
                                              }
                                            }),
                                        snapshot.multipleUploadList[index]
                                                    .uId ==
                                                '0'
                                            ? Container()
                                            : Positioned(
                                                top: 0,
                                                right: 0,
                                                child: SizedBox(
                                                    child: GestureDetector(
                                                        child: CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor:
                                                              Colors.black,
                                                          foregroundColor:
                                                              Colors.black,
                                                          child: Icon(
                                                              Icons.cancel,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        onTap: () {
                                                          _multipleUploadBloc
                                                              .multipleUploadRemove(
                                                                  snapshot
                                                                      .multipleUploadList[
                                                                          index]
                                                                      .uId);
                                                        })))
                                      ]));
                                }))),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(labelRepairMobile,
                          style: TextStyle(
                              fontFamily: quickFont,
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold)),
                      RadioButtonGroup(
                          orientation: GroupedButtonsOrientation.HORIZONTAL,
                          margin: const EdgeInsets.only(left: 0.0),
                          onSelected: (String selected) => setState(() {
                                selectOption = selected;
                              }),
                          labels: <String>[
                            optionAsc,
                            optionHo,
                          ],
                          picked: selectOption,
                          itemBuilder: (Radio rb, Text txt, int i) =>
                              Column(children: <Widget>[
                                rb,
                                txt,
                              ]))
                    ])
              ]))));
}
