import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mobex_go/bloc/ascho/ascho_bloc.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_bloc.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_state.dart';
import 'package:mobex_go/model/imageupload/image_upload.dart';
import 'package:mobex_go/model/multiple_upload.dart';
import 'package:mobex_go/ui/page/collectmobile/tab_collectmobile.dart';
import 'package:mobex_go/utils/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/selectasc/select_asc_bloc.dart';
import 'package:mobex_go/bloc/submitapprove/submit_approve_bloc.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/ui/widget/grouped_buttons_orientation.dart';
import 'package:mobex_go/ui/widget/radio_button_group.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:uuid/uuid.dart';

class SelectStatusApprovePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectStatusApproveState();
}

class _SelectStatusApproveState extends State<SelectStatusApprovePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNotRepairController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  String mobile, name, mobileNotRepair;
  bool _validate = false;

  SelectAscBloc _selectAscBloc;
  UserBloc _userBloc;
  SubmitApproveBloc _submitApproveBloc;
  AscHoBloc _ascHoBloc;
  MultipleUploadBloc _multipleUploadBloc;

  String selectOption = "0";
  File invoiceFile;

  Map<String, bool> collectValue = {
    invoiceCopyApiValue: false,
    collectFaultyPartApiValue: false
  };

  @override
  void initState() {
    _selectAscBloc = BlocProvider.of<SelectAscBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    _submitApproveBloc = BlocProvider.of<SubmitApproveBloc>(context);
    _ascHoBloc = BlocProvider.of<AscHoBloc>(context);

    _multipleUploadBloc = BlocProvider.of<MultipleUploadBloc>(context);
    _multipleUploadBloc.multipleUploadClear();
    _multipleUploadBloc.multipleUploadParam(
        MultipleUpload(file: null, uId: '0'));

    _userBloc.getLoginDetails();
    super.initState();
  }

  _submit() => Stack(children: <Widget>[
        new Positioned(
            child: new Form(
                key: _key,
                autovalidate: _validate,
                child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Column(children: <Widget>[
                        Card(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(children: <Widget>[
                                  Row(children: <Widget>[
                                    Text(_selectAscBloc.currentState.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: quickFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.orange)),
                                    SizedBox(width: 3),
                                  ]),
                                  SizedBox(height: 3),
                                  Row(children: <Widget>[
                                    Text(labelMobile,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: quickFont,
                                            fontSize: 15,
                                            color: Colors.grey)),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: Text(
                                            _selectAscBloc.currentState.brand +
                                                ' - ' +
                                                _selectAscBloc.currentState.model,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black)))
                                  ]),
                                  SizedBox(height: 5),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(labelAddress,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: quickFont,
                                                fontSize: 15,
                                                color: Colors.grey)),
                                        SizedBox(width: 3),
                                        Expanded(
                                            child: Text(
                                                _selectAscBloc.currentState.address,
                                                style: TextStyle(
                                                    fontFamily: quickFont,
                                                    fontSize: 13,
                                                    color: Colors.black)))
                                      ])
                                ]))),
                        _showNameInput(),
                        _showMobileInput(),
                        SizedBox(
                          height: 3,
                        ),
                        ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: collectValue.keys
                                .map((String key) => new CheckboxListTile(
                                    title: Text(key,
                                        style: TextStyle(
                                            fontFamily: quickFont,
                                            color: Colors.black)),
                                    value: collectValue[key],
                                    onChanged: (bool value) {
                                      setState(() {
                                        if (collectValue[invoiceCopyApiValue]) {
                                          invoiceFile = null;
                                        }
                                        collectValue[key] = value;
                                      });
                                    }))
                                .toList()),
                        ListTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                              Text(labelMobileRepairOrNot,
                                  style: new TextStyle(
                                      fontFamily: quickFont,
                                      fontSize: 15.0,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold)),
                              RadioButtonGroup(
                                  orientation:
                                      GroupedButtonsOrientation.HORIZONTAL,
                                  margin: const EdgeInsets.only(left: 0.0),
                                  onSelected: (String selected) => setState(() {
                                        setState(() {
                                          selectOption = selected;
                                        });
                                      }),
                                  labels: <String>[
                                    "YES",
                                    "NO",
                                  ],
                                  picked: selectOption,
                                  itemBuilder: (Radio rb, Text txt, int i) =>
                                      Column(children: <Widget>[
                                        rb,
                                        txt,
                                      ]))
                            ])),
                        selectOption == 'NO'
                            ? _showMobileNotRepairInput()
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          labelReceiveBoxPhoto,
                          style: TextStyle(
                              fontFamily: quickFont,
                              fontSize: 15,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(children: <Widget>[
                          expandStyle(
                              0,
                              collectValue[invoiceCopyApiValue]
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Stack(children: <Widget>[
                                        GestureDetector(
                                            child: Center(
                                                child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.1),
                                                    backgroundImage: invoiceFile ==
                                                            null
                                                        ? ExactAssetImage(
                                                            "assets/images/mobile_box_photo.png")
                                                        : FileImage(invoiceFile),
                                                    child: CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.1),
                                                        foregroundColor:
                                                            Colors.black,
                                                        child: Text('Invoice',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10))))),
                                            onTap: () {
                                              FocusScope.of(context).requestFocus(FocusNode());

                                              Future<File> image = getImage(ImageSource.camera);
                                              image.then((data) {
                                                setState(() {
                                                  invoiceFile = data;
                                                });
                                              }, onError: (e) {});
                                            })
                                      ]))
                                  : Container()),
                          expandStyle(
                              1,
                              Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  height: 100.0,
                                  child: BlocBuilder(
                                      bloc: _multipleUploadBloc,
                                      builder:
                                          (context,
                                                  MultipleUploadState
                                                      snapshot) =>
                                              ListView.builder(
                                                  itemCount: snapshot
                                                      .multipleUploadList
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (BuildContext
                                                          buildContext,
                                                      int index) {
                                                    return Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        child: Stack(
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                  child: Center(
                                                                      child: CircleAvatar(
                                                                          radius:
                                                                              50,
                                                                          backgroundColor: Colors.grey.withOpacity(
                                                                              0.1),
                                                                          backgroundImage: snapshot.multipleUploadList[index].uId == '0'
                                                                              ? ExactAssetImage("assets/images/mobile_box_photo.png")
                                                                              : FileImage(snapshot.multipleUploadList[index].file),
                                                                          child: CircleAvatar(radius: 12, backgroundColor: Colors.black.withOpacity(0.1), foregroundColor: Colors.black, child: Text(snapshot.multipleUploadList[index].uId == '0' ? (snapshot.multipleUploadList.length - 1).toString() : (index + 1).toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10))))),
                                                                  onTap: () {
                                                                    FocusScope.of(context).requestFocus(FocusNode());

                                                                    if (snapshot.multipleUploadList[index].uId == '0' &&
                                                                        snapshot.multipleUploadList.length <=
                                                                            6) {
                                                                      Future<File>
                                                                          image =
                                                                          getImage(ImageSource.camera);
                                                                      image.then(
                                                                          (data) {
                                                                        if (data != null) {
                                                                          _multipleUploadBloc.multipleUploadParam(MultipleUpload(
                                                                            uId: Uuid().v1(),
                                                                            bikerId:  _userBloc.currentState.id,
                                                                            jobId: _selectAscBloc.currentState.jobId,
                                                                            file: data,
                                                                            imageType: receiveImageType
                                                                              ));
                                                                        }
                                                                      },
                                                                          onError:
                                                                              (e) {});
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
                                                                                backgroundColor: Colors.black,
                                                                                foregroundColor: Colors.black,
                                                                                child: Icon(Icons.cancel, color: Colors.white),
                                                                              ),
                                                                              onTap: () {
                                                                                _multipleUploadBloc.multipleUploadRemove(snapshot.multipleUploadList[index].uId);
                                                                              })))
                                                            ]));
                                                  }))))
                        ])
                      ])
                    ])))
      ]);

  _scaffold() => CommonScaffold(
      backGroundColor: Colors.white,
      actionFirstIcon: null,
      appTitle: titleRepairMobileOrNot,
      showDrawer: false,
      bodyData: _submit(),
      showBottom: true,
      bottomData: BottomAppBar(
          elevation: 0.0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            expandStyle(
                1,
                GestureDetector(
                    child: _btnDispatchMobile(btnDispatchMobileCustomer),
                    onTap: () => _sendToServer(dispatchMobileCustomer))),
            expandStyle(
                1,
                GestureDetector(
                    child: _btnDispatchMobile(btnDispatchMobileHo),
                    onTap: () => _sendToServer(dispatchMobileHo)))
          ])));

  _btnDispatchMobile(String text) => Container(
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 5),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        gradient: new LinearGradient(
            colors: [
              Colors.grey.shade100,
              Colors.grey.shade100
            ],
            begin: Alignment.centerRight,
            end: new Alignment(0.0, 0.0),
            tileMode: TileMode.clamp),
      ),
      padding: EdgeInsets.all(10),
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: quickFont, color: Colors.black, fontSize: 15)));

  _showNameInput() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: new TextFormField(
          controller: _nameController,
          decoration: new InputDecoration(
              hintText: inputHintName, labelText: inputHintName),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (str) {
            name = str;
          }));

  _showMobileNotRepairInput() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: new TextFormField(
          controller: _mobileNotRepairController,
          decoration: new InputDecoration(
              hintText: inputHintMobileNotRepair,
              labelText: inputHintMobileNotRepair),
          keyboardType: TextInputType.text,
          validator: validateEmpty,
          onSaved: (str) {
            mobileNotRepair = str;
          }));

  _showMobileInput() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: new TextFormField(
          controller: _mobileController,
          decoration: new InputDecoration(
            hintText: inputHintMobile,
            labelText: inputHintMobile,
          ),
          keyboardType: TextInputType.phone,
          validator: validateMobile,
          onSaved: (str) {
            mobile = str;
          }));

  _sendToServer(bool dispatchMobile) async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_key.currentState.validate()) {
      _key.currentState.save();
      _multipleUploadBloc.ascImageUpload((results) {
        if (selectOption == "0") {
          toast(context, msgSelectMobileRepairOrNot);
        } else if (collectValue[invoiceCopyApiValue] && invoiceFile == null) {
          toast(context, labelInvoicePhoto);
        } else if (results == null) {
          toast(context, msgReceiveMobileBoxHo);
        } else {
          showProgress(context);

          List<String> returnData = new List();
          for (var val in collectValue.values) {
            returnData.add(val.toString());
          }

          List<MultipleUpload> selectImageList = results;
          if (invoiceFile != null) {
            selectImageList.add(MultipleUpload(uId: Uuid().v1(), bikerId: _userBloc.currentState.id, jobId: _selectAscBloc.currentState.jobId,
                file: invoiceFile, imageType: invoiceImageType));
          }

          _submitApproveBloc.fileSelectedList(selectImageList);

          _submitApproveBloc.firebaseUpload((results) {
            List<String> resultUrlList = results;
            if (resultUrlList.isNotEmpty) {
              List<ImageUpload> imageUpload = List();

              for (var url in resultUrlList) {
                List<String> urlSplitList =  url.split('_');
                imageUpload.add(ImageUpload(image: url, imageType: urlSplitList[1]));
              }

              Map<String, dynamic> param = {
                jobIdParam: _selectAscBloc.currentState.jobId,
                bikerIdParam: _userBloc.currentState.id,
                empMobileParam: _userBloc.currentState.mobile,
                repairMobileParam:
                selectOption == 'YES' ? 'REPAIRED' : 'NOT REPAIRED',
                imageParam: imageUpload,
                bikerNameParam: _userBloc.currentState.userName,
                ascPersonNameParam: name,
                ascPersonMobileParam: mobile,
                invoiceGetParam: returnData[0],
                faultyPartParam: returnData[1],
                dispatchMobileParam: dispatchMobile,
                mobileNotRepairDescriptionParam:
                mobileNotRepair == null ? '' : mobileNotRepair
              };

              _submitApproveBloc.mapParamInput(param);
              _submitApproveToApi();
            }
            else{
              hideProgress(context);
            }
          });
        }
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  _submitApproveToApi() async {
    _submitApproveBloc.submitApprove((results) {
      if (results is ApiResponse) {
        hideProgress(context);
        var apiResponse = results;

        if (apiResponse.responseCode == apiCode1) {
          _ascHoBloc.jobIdParam(_selectAscBloc.currentState.jobId);
          _ascHoBloc.ascHoRemove();
          toast(context, apiResponse.responseMessage);

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              TabCollectMobile(id: 1)), (Route<dynamic> route) => false);
        } else {
          toast(context, rejectNotSuccessfulMessage);
        }
      } else {
        toast(context, results);
        hideProgress(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) => _scaffold();

/* @override
  void dispose() {
    _selectAscBloc.close();
    _userBloc.close();
    _submitApproveBloc.close();
    _ascHoBloc.close();
    super.dispose();
  }*/
}
