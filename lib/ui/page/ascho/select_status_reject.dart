import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mobex_go/bloc/ascho/ascho_bloc.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_bloc.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_state.dart';
import 'package:mobex_go/model/imageupload/image_upload.dart';
import 'package:mobex_go/model/multiple_upload.dart';
import 'package:mobex_go/ui/page/collectmobile/tab_collectmobile.dart';
import 'package:mobex_go/utils/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/selectasc/select_asc_bloc.dart';
import 'package:mobex_go/bloc/submitapprove/submit_approve_bloc.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:uuid/uuid.dart';

class SelectStatusRejectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectStatusRejectState();
}

class _SelectStatusRejectState extends State<SelectStatusRejectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  SelectAscBloc _selectAscBloc;
  UserBloc _userBloc;
  SubmitApproveBloc _submitApproveBloc;
  AscHoBloc _ascHoBloc;

  String mobile, name;
  bool _validate = false;
  MultipleUploadBloc _multipleUploadBloc;

  @override
  void initState() {
    _selectAscBloc = BlocProvider.of<SelectAscBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    _submitApproveBloc = BlocProvider.of<SubmitApproveBloc>(context);
    _ascHoBloc = BlocProvider.of<AscHoBloc>(context);

    _multipleUploadBloc = BlocProvider.of<MultipleUploadBloc>(context);
    _multipleUploadBloc.multipleUploadClear();
    _multipleUploadBloc
        .multipleUploadParam(MultipleUpload(file: null, uId: '0'));

    _userBloc.getLoginDetails();

    super.initState();
  }

/*  @override
  void dispose() {
    _selectAscBloc.close();
    _userBloc.close();
    _submitApproveBloc.close();
    _ascHoBloc.close();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) => _scaffold();

  _submit() => Form(
      key: _key,
      autovalidate: _validate,
      child: ListView(children: <Widget>[
        Container(
            child: Column(children: <Widget>[
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
                      Text('Mobile: ',
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
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black)))
                    ]),
                    SizedBox(height: 5),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Address: ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: quickFont,
                                  fontSize: 15,
                                  color: Colors.grey)),
                          SizedBox(width: 3),
                          Expanded(
                              child: Text(_selectAscBloc.currentState.address,
                                  style: TextStyle(
                                      fontFamily: quickFont,
                                      fontSize: 13,
                                      color: Colors.black)))
                        ])
                  ]))),
          _showNameInput(),
          _showMobileInput(),
          SizedBox(
            height: 20,
          ),
          Text(
            labelRejectBoxPhoto,
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
                          itemCount: snapshot.multipleUploadList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return Container(
                                padding: EdgeInsets.all(2),
                                child: Stack(children: <Widget>[
                                  GestureDetector(
                                      child: Center(
                                          child: CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.1),
                                              backgroundImage: snapshot.multipleUploadList[index].uId == '0'
                                                  ? ExactAssetImage(
                                                      "assets/images/mobile_box_photo.png")
                                                  : FileImage(snapshot
                                                      .multipleUploadList[index]
                                                      .file),
                                              child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.black
                                                      .withOpacity(0.1),
                                                  foregroundColor: Colors.black,
                                                  child: Text(
                                                      snapshot.multipleUploadList[index].uId == '0'
                                                          ? (snapshot.multipleUploadList.length - 1)
                                                              .toString()
                                                          : (index + 1)
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 10))))),
                                      onTap: () {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        if (snapshot.multipleUploadList[index]
                                                    .uId ==
                                                '0' &&
                                            snapshot.multipleUploadList
                                                    .length <=
                                                6) {
                                          Future<File> image = getImage(ImageSource.camera);
                                          image.then((data) {
                                            if (data != null) {
                                              _multipleUploadBloc
                                                  .multipleUploadParam(
                                                      MultipleUpload(
                                                        uId: Uuid().v1(),
                                                        bikerId: _userBloc.currentState.id,
                                                        jobId: _selectAscBloc.currentState.jobId, file: data,
                                                        imageType: receiveImageType));
                                            }
                                          }, onError: (e) {});
                                        }
                                      }),
                                  snapshot.multipleUploadList[index].uId == '0'
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
                                                    child: Icon(Icons.cancel,
                                                        color: Colors.white),
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
                          })))
        ]))
      ]));

  _scaffold() => CommonScaffold(
      backGroundColor: Colors.white,
      actionFirstIcon: null,
      appTitle: titleEstimateReject,
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: quickFont, color: Colors.black, fontSize: 15)));

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

  _sendToServer(bool dispatchMobile) async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _multipleUploadBloc.ascImageUpload((results) {
        if (results == null) {
          toast(context, msgRejectMobileBoxPhoto);
        } else {
          showProgress(context);
          List<MultipleUpload> selectImageList = results;
          _submitApproveBloc.fileSelectedList(selectImageList);

          _submitApproveBloc.firebaseUpload((results) {
            List<String> resultUrlList = results;
            if (resultUrlList.isNotEmpty) {
              List<ImageUpload> imageUpload = List();

              for (var url in resultUrlList) {
                List<String> urlSplitList =  url.split('_');
                imageUpload
                    .add(ImageUpload(image: url, imageType: urlSplitList[1]));
              }

              Map<String, dynamic> param = {
                jobIdParam: _selectAscBloc.currentState.jobId,
                bikerIdParam: _userBloc.currentState.id,
                repairMobileParam: notRepairedApiStatus,
                imageParam: imageUpload,
                bikerNameParam: _userBloc.currentState.userName,
                empMobileParam: _userBloc.currentState.mobile,
                ascPersonNameParam: name,
                ascPersonMobileParam: mobile,
                invoiceGetParam: "",
                faultyPartParam: "",
                dispatchMobileParam: dispatchMobile,
                mobileNotRepairDescriptionParam: ""
              };

              _submitApproveBloc.mapParamInput(param);
              _submitRejectToApi();
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

  _submitRejectToApi() async {
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
          toast(context, msgRejectNotSuccessful);
        }
      } else {
        toast(context, results);
        hideProgress(context);
      }
    });
  }
}
