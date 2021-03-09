import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_bloc.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_state.dart';
import 'package:mobex_go/model/imageupload/image_upload.dart';
import 'package:mobex_go/model/multiple_upload.dart';
import 'package:mobex_go/utils/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/asc/asc_bloc.dart';
import 'package:mobex_go/bloc/asc/asc_state.dart';
import 'package:mobex_go/bloc/selectasc/select_asc_bloc.dart';
import 'package:mobex_go/bloc/submitasc/submit_asc_bloc.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/model/asc/asc_list.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:uuid/uuid.dart';

class SelectStatusAscPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectStatusAscState();
}

class _SelectStatusAscState extends State<SelectStatusAscPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  String mobile, name;
  bool _validate = false;
  String ascName, ascCode, ascAddress;

  AscBloc _ascBloc;
  SelectAscBloc _selectAscBloc;
  UserBloc _userBloc;
  SubmitAscBloc _submitAscBloc;
  MultipleUploadBloc _multipleUploadBloc;
  bool isAscSelect = false;

  @override
  void initState() {
    _selectAscBloc = BlocProvider.of<SelectAscBloc>(context);
    _ascBloc = BlocProvider.of<AscBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    _submitAscBloc = BlocProvider.of<SubmitAscBloc>(context);

    _multipleUploadBloc = BlocProvider.of<MultipleUploadBloc>(context);
    _multipleUploadBloc.multipleUploadClear();
    _multipleUploadBloc
        .multipleUploadParam(MultipleUpload(file: null, uId: '0'));

    _userBloc.getLoginDetails();
    _ascBloc.asc(_selectAscBloc.currentState.jobId.toString());

    super.initState();
  }

/*  @override
  void dispose() {
    _selectAscBloc.close();
    _ascBloc.close();
    _userBloc.close();
    _submitAscBloc.close();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) => _scaffold();

  _bodyData() => BlocBuilder(
      bloc: _ascBloc,
      builder: (context, AscState snapshot) => snapshot.loading
          ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorProgressBar)),
            )
          : _bodyList(snapshot.ascList, snapshot.errorMessage));

  _bodyList(List<AscListResponse> ascList, errorMessage) => Container(
          child: Stack(children: <Widget>[
        Form(
            key: _key,
            autovalidate: _validate,
            child: ascList.isEmpty
                ? ListView(children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(errorMessage,
                                  style: TextStyle(
                                      color: colorNoData,
                                      fontSize: 20,
                                      fontFamily: quickFont))
                            ]))
                  ])
                : isAscSelect
                    ? ListView(children: <Widget>[
                        Column(children: <Widget>[
                          Card(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(children: <Widget>[
                                    expandStyle(
                                        1,
                                        Column(children: <Widget>[
                                          Row(children: <Widget>[
                                            Expanded(
                                                child: Text(ascName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: quickFont,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black)))
                                          ]),
                                          SizedBox(height: 3),
                                          Row(children: <Widget>[
                                            Expanded(
                                                child: Text(ascAddress,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: quickFont,
                                                        fontSize: 13,
                                                        color: Colors.grey)))
                                          ]),
                                          SizedBox(height: 15),
                                          Row(children: <Widget>[
                                            Text(
                                                _selectAscBloc
                                                    .currentState.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: quickFont,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                            SizedBox(width: 3),
                                          ]),
                                          SizedBox(height: 3),
                                          Row(children: <Widget>[
                                            Text('Mobile: ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: quickFont,
                                                    fontSize: 15,
                                                    color: Colors.grey)),
                                            SizedBox(width: 3),
                                            Expanded(
                                                child: Text(
                                                    _selectAscBloc.currentState
                                                            .brand +
                                                        ' - ' +
                                                        _selectAscBloc
                                                            .currentState.model,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: quickFont,
                                                        fontSize: 13,
                                                        color: Colors.black)))
                                          ]),
                                          Row(children: <Widget>[
                                            Text('Address: ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: quickFont,
                                                    fontSize: 15,
                                                    color: Colors.grey)),
                                            SizedBox(width: 3),
                                            Expanded(
                                                child: Text(
                                                    _selectAscBloc
                                                        .currentState.address,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: quickFont,
                                                        fontSize: 13,
                                                        color: Colors.black)))
                                          ])
                                        ])),
                                    GestureDetector(
                                      child:
                                          Icon(Icons.clear, color: Colors.grey),
                                      onTap: () {
                                        ascName = null;
                                        ascCode = null;
                                        ascAddress = null;

                                        _nameController.clear();
                                        _mobileController.clear();

                                        setState(() {
                                          isAscSelect = false;
                                        });
                                      },
                                    )
                                  ]))),
                          _showNameInput(),
                          _showMobileInput(),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Column(children: <Widget>[
                            Text(
                              labelMobileBoxPhoto,
                              style: TextStyle(
                                  fontFamily: quickFont,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 20.0),
                                height: 100.0,
                                child: BlocBuilder(
                                    bloc: _multipleUploadBloc,
                                    builder:
                                        (context,
                                                MultipleUploadState snapshot) =>
                                            ListView.builder(
                                                itemCount: snapshot
                                                    .multipleUploadList.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext buildContext,
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
                                                                        backgroundColor: Colors
                                                                            .grey
                                                                            .withOpacity(
                                                                                0.1),
                                                                        backgroundImage: snapshot.multipleUploadList[index].uId == '0'
                                                                            ? ExactAssetImage(
                                                                                "assets/images/mobile_box_photo.png")
                                                                            : FileImage(snapshot
                                                                                .multipleUploadList[
                                                                                    index]
                                                                                .file),
                                                                        child: CircleAvatar(
                                                                            radius:
                                                                                12,
                                                                            backgroundColor:
                                                                                Colors.black.withOpacity(0.1),
                                                                            foregroundColor: Colors.black,
                                                                            child: Text(snapshot.multipleUploadList[index].uId == '0' ? (snapshot.multipleUploadList.length - 1).toString() : (index + 1).toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10))))),
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          FocusNode());
                                                                  if (snapshot.multipleUploadList[index].uId ==
                                                                          '0' &&
                                                                      snapshot.multipleUploadList
                                                                              .length <=
                                                                          6) {
                                                                    Future<File>
                                                                        image =
                                                                        getImage(
                                                                            ImageSource.camera);
                                                                    image.then(
                                                                        (data) {
                                                                      if (data !=
                                                                          null) {
                                                                        _multipleUploadBloc.multipleUploadParam(MultipleUpload(
                                                                            bikerId: _userBloc
                                                                                .currentState.id,
                                                                            jobId: _selectAscBloc
                                                                                .currentState.jobId,
                                                                            uId: Uuid()
                                                                                .v1(),
                                                                            file:
                                                                                data,
                                                                            imageType:
                                                                                ascSubmitImageType));
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
                                                })))
                          ]))
                        ])
                      ])
                    : Column(children: <Widget>[_selectName(ascList)])),
      ]));

  _scaffold() => CommonScaffold(
      backGroundColor: Colors.white,
      actionFirstIcon: null,
      appTitle: "Select ASC",
      showDrawer: false,
      bodyData: _bodyData(),
      showBottom: true,
      bottomData: isAscSelect
          ? BottomAppBar(
              elevation: 0.0,
              child: GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade100,
                              Colors.grey.shade100
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment(0.0, 0.0),
                            tileMode: TileMode.clamp),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(btnAscSubmit,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: quickFont,
                              color: Colors.black,
                              fontSize: 15))),
                  onTap: () => _sendToServer()))
          : null);

  _selectName(List<AscListResponse> ascList) => Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: ascList.length,
          itemBuilder: (BuildContext context, int index) => InkWell(
              splashColor: Colors.black12,
              onTap: () {
                setState(() {
                  setState(() {
                    ascList.forEach((element) => element.isSelected = false);
                    ascList[index].isSelected = true;
                    isAscSelect = true;

                    ascName = ascList[index].name;
                    ascCode = ascList[index].vendCode;
                    ascAddress = ascList[index].address1;
                  });
                });
              },
              child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Container(
                      child: Icon(
                          ascList[index].isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: ascList[index].isSelected
                              ? Colors.deepOrangeAccent
                              : Colors.black),
                    ),
                    expandStyle(
                        1,
                        Container(
                            margin: EdgeInsets.only(top: 5.0, left: 10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(ascList[index].name,
                                      style: TextStyle(
                                        fontFamily: quickFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: ascList[index].isSelected
                                            ? Colors.deepOrangeAccent
                                            : Colors.black,
                                      )),
                                  SizedBox(height: 3),
                                  Text(ascList[index].address1,
                                      style: TextStyle(
                                          fontFamily: quickFont,
                                          fontSize: 14,
                                          color: Colors.black45))
                                ])))
                  ])))));

  _showNameInput() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
              hintText: inputHintName, labelText: inputHintName),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (str) {
            name = str;
          }));

  _showMobileInput() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: TextFormField(
          controller: _mobileController,
          decoration: InputDecoration(
            hintText: inputHintMobile,
            labelText: inputHintMobile,
          ),
          keyboardType: TextInputType.phone,
          validator: validateMobile,
          onSaved: (str) {
            mobile = str;
          }));

  _sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      _multipleUploadBloc.ascImageUpload((results) {
        if (results == null) {
          toast(context, labelMobileBoxPhoto);
        } else {
          showProgress(context);
          List<MultipleUpload> selectImageList = results;
          _submitAscBloc.fileSelectedList(selectImageList);

          _submitAscBloc.firebaseUpload((results) {
            List<String> resultUrlList = results;
            if (resultUrlList.isNotEmpty) {
              List<ImageUpload> imageUpload = List();

              for (var url in resultUrlList) {
                List<String> urlSplitList = url.split('_');
                imageUpload
                    .add(ImageUpload(image: url, imageType: urlSplitList[1]));
              }

              Map<String, dynamic> param = {
                jobIdParam: _selectAscBloc.currentState.jobId,
                ascNameParam: ascName,
                ascCodeParam: ascCode,
                bikerIdParam: _userBloc.currentState.id,
                problemMobileParam: "",
                ascPersonNameParam: name,
                ascPersonMobileParam: mobile,
                imageParam: imageUpload,
                bikerNameParam: _userBloc.currentState.userName
              };

              _submitAscBloc.mapParamInput(param);
              _submitAscToApi();
            } else {
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

  _submitAscToApi() async {
    _submitAscBloc.submitAsc((results) {
      if (results is ApiResponse) {
        hideProgress(context);
        var apiResponse = results;

        if (apiResponse.responseCode == apiCode1) {
          toast(context, apiResponse.responseMessage);
          Navigator.pop(context, apiCode1);
        } else {
          toast(context, msgAscMobileNotSubmitted);
        }
      } else {
        toast(context, msgAscNotSubmit);
        hideProgress(context);
      }
    });
  }
}
