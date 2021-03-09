import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_bloc.dart';
import 'package:mobex_go/bloc/multipleupload/multiple_upload_state.dart';
import 'package:mobex_go/model/imageupload/create_estimate_image_upload.dart';
import 'package:mobex_go/model/multiple_upload.dart';
import 'package:mobex_go/utils/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/asc/asc_bloc.dart';
import 'package:mobex_go/bloc/asc/asc_state.dart';
import 'package:mobex_go/bloc/selectasc/select_asc_bloc.dart';
import 'package:mobex_go/bloc/submitestimate/submit_estimate_bloc.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/model/asc/problem_list.dart';
import 'package:mobex_go/model/createestimate/asc_give_charge.dart';
import 'package:mobex_go/model/createestimate/create_estimate_json.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:uuid/uuid.dart';

class SelectStatusEstimateCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectStatusEstimateCreateState();
}

class _SelectStatusEstimateCreateState
    extends State<SelectStatusEstimateCreatePage> {
  AscBloc _ascBloc;
  SelectAscBloc _selectAscBloc;
  UserBloc _userBloc;
  SubmitEstimateBloc _submitEstimateBloc;
  MultipleUploadBloc _multipleUploadBloc;
  List<TextEditingController> _controllers = new List();

  @override
  void initState() {
    _selectAscBloc = BlocProvider.of<SelectAscBloc>(context);
    _ascBloc = BlocProvider.of<AscBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    _submitEstimateBloc = BlocProvider.of<SubmitEstimateBloc>(context);

    _multipleUploadBloc = BlocProvider.of<MultipleUploadBloc>(context);
    _multipleUploadBloc.multipleUploadClear();
    _multipleUploadBloc
        .multipleUploadParam(MultipleUpload(file: null, uId: '0'));

    _userBloc.getLoginDetails();
    _ascBloc.asc(_selectAscBloc.currentState.jobId.toString());
    super.initState();
  }

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
          : snapshot.problemList.isEmpty
              ? Container(
                  child: Center(
                      child: (Text(snapshot.errorMessage,
                          style: TextStyle(
                              color: colorNoData,
                              fontSize: 20,
                              fontFamily: quickFont)))))
              : _problemList(snapshot));

  _problemList(AscState snapshot) => Column(children: <Widget>[
        expandStyle(1, _bodyList(snapshot.problemList)),
        expandStyle(
            0,
            Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _ascBloc.currentState.selectPcbSubPcb.length >= 1
                          ? Text(
                              labelPcBSubPcbPhoto,
                              style: TextStyle(
                                  fontFamily: quickFont,
                                  fontSize: 15,
                                  color: Colors.grey),
                            )
                          : Container(),
                      _ascBloc.currentState.selectPcbSubPcb.length >= 1
                          ? Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              height: 100.0,
                              child: BlocBuilder(
                                  bloc: _multipleUploadBloc,
                                  builder:
                                      (context, MultipleUploadState snapshot) =>
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                  .multipleUploadList.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext buildContext,
                                                      int index) {
                                                return Container(
                                                    padding: EdgeInsets.all(2),
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
                                                                          backgroundColor: Colors.black.withOpacity(
                                                                              0.1),
                                                                          foregroundColor: Colors
                                                                              .black,
                                                                          child: Text(
                                                                              snapshot.multipleUploadList[index].uId == '0' ? (snapshot.multipleUploadList.length - 1).toString() : (index + 1).toString(),
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10))))),
                                                              onTap: () {
                                                                if (snapshot
                                                                            .multipleUploadList[
                                                                                index]
                                                                            .uId ==
                                                                        '0' &&
                                                                    snapshot.multipleUploadList
                                                                            .length <=
                                                                        _ascBloc
                                                                            .currentState
                                                                            .selectPcbSubPcb
                                                                            .length) {
                                                                  Future<File>
                                                                      image =
                                                                      getImage(
                                                                          ImageSource
                                                                              .gallery);
                                                                  image.then(
                                                                      (data) {
                                                                    if (data !=
                                                                        null) {
                                                                      _multipleUploadBloc.multipleUploadParam(MultipleUpload(
                                                                          uId: Uuid()
                                                                              .v1(),
                                                                          bikerId: _userBloc
                                                                              .currentState
                                                                              .id,
                                                                          jobId: _selectAscBloc
                                                                              .currentState
                                                                              .jobId,
                                                                          file:
                                                                              data,
                                                                          imageType:
                                                                              createEstimateImageType));
                                                                    }
                                                                  },
                                                                      onError:
                                                                          (e) {});
                                                                }
                                                              }),
                                                          snapshot
                                                                      .multipleUploadList[
                                                                          index]
                                                                      .uId ==
                                                                  '0'
                                                              ? Container()
                                                              : Positioned(
                                                                  top: 0,
                                                                  right: 0,
                                                                  child: SizedBox(
                                                                      child: GestureDetector(
                                                                          child: CircleAvatar(
                                                                            radius:
                                                                                12,
                                                                            backgroundColor:
                                                                                Colors.black,
                                                                            foregroundColor:
                                                                                Colors.black,
                                                                            child:
                                                                                Icon(Icons.cancel, color: Colors.white),
                                                                          ),
                                                                          onTap: () {
                                                                            _multipleUploadBloc.multipleUploadRemove(snapshot.multipleUploadList[index].uId);
                                                                          })))
                                                        ]));
                                              })))
                          : Container(),
                      Row(children: <Widget>[
                        expandStyle(
                            3,
                            Text(labelTotalAmountIncludeGst,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey))),
                        expandStyle(
                            1,
                            Text(
                                double.parse(snapshot.totalEstimate
                                        .toStringAsFixed(0))
                                    .toString(),
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green))),
                      ])
                    ])))
      ]);

  _bodyList(List<ProblemListResponse> problemList) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: problemList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        _controllers.add(new TextEditingController());
        _controllers[index].text = problemList[index].enterValue;

        return Container(
            padding: EdgeInsets.only(top: 0, right: 10, left: 10),
            child: Row(children: <Widget>[
              expandStyle(
                  2,
                  Container(
                      margin: EdgeInsets.only(top: 35),
                      child: Text(problemList[index].problemName,
                          style: TextStyle(fontFamily: quickFont)))),
              expandStyle(
                  1,
                  TextFormField(
                      controller: new TextEditingController.fromValue(
                          new TextEditingValue(
                              text: problemList[index].enterValue,
                              selection: new TextSelection.collapsed(
                                  offset:
                                      problemList[index].enterValue.length))),
                      keyboardType: TextInputType.number,
                      onChanged: (String str) {
                        if (str.isEmpty) {
                          if (problemList[index].problemName.toLowerCase() ==
                                  'PCB'.toLowerCase() ||
                              problemList[index].problemName.toLowerCase() ==
                                  'SUB PCB'.toLowerCase()) {
                            _multipleUploadBloc.multipleUploadClear();
                            _multipleUploadBloc.multipleUploadParam(
                                MultipleUpload(file: null, uId: '0'));
                          }
                          _ascBloc.totalEstimate(problemList[index].id, '');
                        } else {
                          _ascBloc.totalEstimate(problemList[index].id, str);
                        }
                      }))
            ]));
      });

  _scaffold() => CommonScaffold(
      backGroundColor: Colors.white,
      actionFirstIcon: null,
      appTitle: titleCreateEstimate,
      showDrawer: false,
      bodyData: _bodyData(),
      showBottom: true,
      bottomData: BottomAppBar(
          elevation: 0.0,
          child: GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.grey.shade100, Colors.grey.shade100],
                        begin: Alignment.centerRight,
                        end: Alignment(0.0, 0.0),
                        tileMode: TileMode.clamp),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(btnAscOfEstimate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: quickFont,
                          color: Colors.black,
                          fontSize: 15))),
              onTap: () =>  _ascBloc.currentState.problemList.isEmpty ? toast(context, _ascBloc.currentState.errorMessage) :_sendToServer())));

  _sendToServer() {
    if (_ascBloc.currentState.selectPcbSubPcb.length >= 1) {
      _multipleUploadBloc.ascImageUpload((results) {
        if (_ascBloc.currentState.totalEstimate == 0.0) {
          toast(context, msgEstimateAmountValueEmpty);
        } else if (_ascBloc.currentState.mustServiceCharge == false) {
          toast(context, msgServiceCharge);
        } else if (results == null) {
          toast(context, msgPcBSubPcbPhoto);
        } else if (results.length ==
            _ascBloc.currentState.selectPcbSubPcb.length) {
          toast(context, msgPcBSubPcb2Photo);
        } else {
          showProgress(context);
          List<MultipleUpload> selectImageList = results;
          _submitEstimateBloc.fileSelectedList(selectImageList);
          _submitEstimateBloc.firebaseUpload((results) {
            List<String> resultUrlList = results;
            if (resultUrlList.isNotEmpty) {
              List<CreateEstimateImageUpload> listCreateEstimateImageUpload =
                  new List();

              for (var url in resultUrlList) {
                List<String> urlSplitList = url.split('_');
                listCreateEstimateImageUpload.add(CreateEstimateImageUpload(
                    jobId: _selectAscBloc.currentState.jobId,
                    userId: _userBloc.currentState.id,
                    userName: _userBloc.currentState.userName,
                    image: url,
                    imageType: urlSplitList[1]));
              }

              List<ASCGiveCharge> listASCGiveCharge = List();
              String serviceCharges;

              for (ProblemListResponse problem
                  in _ascBloc.currentState.problemList) {
                if (problem.enterValue.isNotEmpty) {
                  if (problem.problemName.toLowerCase() ==
                      'SERVICE CHARGES'.toLowerCase()) {
                    serviceCharges = problem.enterValue;
                  } else {
                    listASCGiveCharge.add(ASCGiveCharge(
                        problem.id.toString(),
                        1.0,
                        double.parse(problem.enterValue),
                        double.parse(problem.enterValue),
                        problem.netRate,
                        double.parse(problem.enterValue),
                        problem.pId.toString(),
                        problem.operator,
                        problem.condId.toString(),
                        problem.condType));
                  }
                }
              }
              double serviceCharge2Digit = double.parse(serviceCharges);
              double minusServiceCharge = double.parse(
                      _ascBloc.currentState.totalEstimate.toStringAsFixed(2)) -
                  double.parse(serviceCharge2Digit.toStringAsFixed(2));

              CreateEstimateJson entry = CreateEstimateJson(
                  _userBloc.currentState.id,
                  double.parse(minusServiceCharge.toStringAsFixed(2)),
                  _selectAscBloc.currentState.jobId,
                  listASCGiveCharge,
                  "",
                  serviceCharges,
                  listCreateEstimateImageUpload: listCreateEstimateImageUpload);

              _submitEstimateBloc.jsonParam(json.encode(entry));
              _submitEstimateToApi(_ascBloc.currentState.totalEstimate);
            }
          });
        }
      });
    } else {
      List<ASCGiveCharge> listASCGiveCharge = List();
      String serviceCharges;
      for (ProblemListResponse problem in _ascBloc.currentState.problemList) {
        if (problem.enterValue.isNotEmpty) {
          if (problem.problemName.toLowerCase() ==
              'SERVICE CHARGES'.toLowerCase()) {
            serviceCharges = problem.enterValue;
          } else {
            listASCGiveCharge.add(ASCGiveCharge(
                problem.id.toString(),
                1.0,
                double.parse(problem.enterValue),
                double.parse(problem.enterValue),
                problem.netRate,
                double.parse(problem.enterValue),
                problem.pId.toString(),
                problem.operator,
                problem.condId.toString(),
                problem.condType));
          }
        }
      }
      if (_ascBloc.currentState.totalEstimate == 0.0) {
        toast(context, msgEstimateAmountValueEmpty);
      } else if (_ascBloc.currentState.mustServiceCharge == false) {
        toast(context, msgServiceCharge);
      } else {
        showProgress(context);
        double serviceCharge2Digit = double.parse(serviceCharges);
        double minusServiceCharge = double.parse(
                _ascBloc.currentState.totalEstimate.toStringAsFixed(2)) -
            double.parse(serviceCharge2Digit.toStringAsFixed(2));
        CreateEstimateJson entry = CreateEstimateJson(
            _userBloc.currentState.id,
            double.parse(minusServiceCharge.toStringAsFixed(2)),
            _selectAscBloc.currentState.jobId,
            listASCGiveCharge,
            "",
            serviceCharges);

        _submitEstimateBloc.jsonParam(json.encode(entry));
        _submitEstimateToApi(_ascBloc.currentState.totalEstimate);
      }
    }
  }

  _submitEstimateToApi(double totalAmount) {
    _submitEstimateBloc.submitEstimate((results) {
      if (results is ApiResponse) {
        hideProgress(context);
        var apiResponse = results;

        if (apiResponse.responseCode == apiCode1) {
          toast(context, apiResponse.responseMessage);
          Navigator.pop(context, totalAmount.toString());
        } else {
          toast(context, msgNotCreateEstimate);
        }
      } else {
        toast(context, results);
        hideProgress(context);
      }
    });
  }
}
