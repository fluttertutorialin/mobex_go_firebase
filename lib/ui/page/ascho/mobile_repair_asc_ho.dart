import 'dart:async';
import 'dart:ui';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/ascho/ascho_bloc.dart';
import 'package:mobex_go/bloc/ascho/ascho_state.dart';
import 'package:mobex_go/bloc/selectasc/select_asc_bloc.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/model/assignascho/assign_asc_ho_response.dart';
import 'package:mobex_go/ui/page/collectmobile/delivery_row.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/ui/widget/custom_delivery_button.dart';
import 'package:mobex_go/ui/widget/ios_search_bar.dart';
import 'package:mobex_go/utils/vars.dart';
import 'select_status_approve.dart';
import 'select_status_asc.dart';
import 'select_status_estimate_create.dart';
import 'select_status_reject.dart';

class MobileRepairAscHoPage extends StatefulWidget {
  @override
  _MobileRepairAscHoState createState() => _MobileRepairAscHoState();
}

class _MobileRepairAscHoState extends State<MobileRepairAscHoPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final _scaffoldState = GlobalKey<ScaffoldState>();

  AscHoBloc _ascHoBloc;
  UserBloc _userBloc;
  SelectAscBloc _selectAscBloc;

  TextEditingController _searchTextController = new TextEditingController();
  FocusNode _searchFocusNode = new FocusNode();
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.getLoginDetails();

    _ascHoBloc = BlocProvider.of<AscHoBloc>(context);
    _ascHoBloc.ascHo(_userBloc.currentState.id);
    _selectAscBloc = BlocProvider.of<SelectAscBloc>(context);

    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  Future<void> _onRefresh() async {
    Timer(Duration(seconds: 3), () {
      _ascHoBloc.ascHo(_userBloc.currentState.id);
    });
  }

  _bodyData() => BlocBuilder(
      bloc: _ascHoBloc,
      builder: (context, AscHoState snapshot) => snapshot.loading
          ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorProgressBar)),
            )
          : _bodyList(snapshot.ascHoList, snapshot.errorMessage));

  _bodyList(List<AssignAscHoResponse> assignAscHoList, String errorMessage) =>
      RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _onRefresh,
          child: Stack(children: <Widget>[
            assignAscHoList.isEmpty
                ? ListView(padding: EdgeInsets.all(0), children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height / 1.2,
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
                    padding: EdgeInsets.all(0),
                    itemCount: assignAscHoList.length,
                    itemBuilder: (context, position) => Card(
                        color: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10.0),
                              top: Radius.circular(2.0)),
                        ),
                        child: Column(children: <Widget>[
                          DeliveryRow(
                              assignAscHoList[position].jobId,
                              assignAscHoList[position].name,
                              assignAscHoList[position].brand,
                              assignAscHoList[position].mobile,
                              assignAscHoList[position].address,
                              assignAscHoList[position].model,
                              assignAscHoList[position].pickUpDateTime,
                              amount: assignAscHoList[position].estimate,
                              assign: assignAscHoList[position].assign),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                _btnId(assignAscHoList[position].status) == 2
                                    ? Text(
                                        labelEstimate +
                                            assignAscHoList[position]
                                                .status
                                                .toLowerCase(),
                                        style: (TextStyle(
                                            fontSize: 11,
                                            fontFamily: ralewayFont,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blueGrey)))
                                    : _btnId(assignAscHoList[position]
                                                .status) ==
                                            3
                                        ? Text(
                                            labelEstimate +
                                                assignAscHoList[position]
                                                    .status
                                                    .toLowerCase(),
                                            style: (TextStyle(
                                                fontSize: 11,
                                                fontFamily: ralewayFont,
                                                letterSpacing: 0.1,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.deepOrange)))
                                        : Container(),
                                assignAscHoList[position].assign == statusHo
                                    ? CustomDeliveryButton(
                                        textColor: Colors.orange,
                                        btnName: btnHoSubmit,
                                        qrCallback: () {
                                          _ascHoBloc.jobIdParam(
                                              assignAscHoList[position].jobId);
                                          _submitHoToApi();
                                        })
                                    : CustomDeliveryButton(
                                        textColor: _btnId(
                                                    assignAscHoList[position]
                                                        .status) ==
                                                -1
                                            ? Colors.deepOrangeAccent
                                            : _btnId(assignAscHoList[position]
                                                        .status) ==
                                                    3
                                                ? Colors.orange
                                                : Colors.indigoAccent,
                                        btnName: _btnId(
                                                    assignAscHoList[position]
                                                        .status) ==
                                                2
                                            ? statusApproveOrRejectFor
                                            : _btnId(assignAscHoList[position]
                                                        .status) ==
                                                    3
                                                ? statusApproveOrRejectFor
                                                : _btnName(
                                                    assignAscHoList[position]
                                                        .status),
                                        qrCallback: () async {
                                          int movePage = _btnId(
                                              assignAscHoList[position].status);
                                          if (movePage != -1) {
                                            _selectAscBloc.saveInquiryNo(
                                                assignAscHoList[position]
                                                    .inquiryNo);
                                            _selectAscBloc.saveJobId(
                                                assignAscHoList[position]
                                                    .jobId);
                                            _selectAscBloc.saveName(
                                                assignAscHoList[position].name);
                                            _selectAscBloc.saveBrand(
                                                assignAscHoList[position]
                                                    .brand);
                                            _selectAscBloc.saveMobile(
                                                assignAscHoList[position]
                                                    .mobile);
                                            _selectAscBloc.saveAddress(
                                                assignAscHoList[position]
                                                    .address);
                                            _selectAscBloc.saveModel(
                                                assignAscHoList[position]
                                                    .model);

                                            if (movePage == 0) {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              final result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectStatusAscPage()),
                                              );

                                              if (result != null) {
                                                _ascHoBloc.ascStatusUpdate(
                                                    assignAscHoList[position],
                                                    statusAtASC);
                                              }
                                            } else if (movePage == 1) {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              String result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectStatusEstimateCreatePage()),
                                              );

                                              if (result != null) {
                                                _ascHoBloc.ascStatusUpdate(
                                                    assignAscHoList[position],
                                                    statusWaitingForApproval,
                                                    estimate: result);
                                              }
                                            } else if (movePage == 2) {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectStatusApprovePage()),
                                              );
                                            } else if (movePage == 3) {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SelectStatusRejectPage()));
                                            }
                                          }
                                        })
                              ])
                        ])))
          ]));

  void _cancelSearch() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
    _ascHoBloc.searchInput('');
  }

  void _clearSearch() {
    _searchTextController.clear();
    _ascHoBloc.searchInput('');
  }

  _submitHoToApi() {
    showProgress(context);
    _ascHoBloc.submitHo((results) {
      if (results is ApiResponse) {
        hideProgress(context);
        var apiResponse = results;
        if (apiResponse.responseCode == apiCode1) {
          _ascHoBloc.ascHoRemove();
        } else {
          toast(context, msgHoMobileNotSubmitted);
        }
      } else {
        toast(context, results);
        hideProgress(context);
      }
    });
  }

  String _btnName(String status) {
    if (status.toLowerCase() == statusProductPickedUp.toLowerCase()) {
      return statusProductPickedUpFor;
    } else if (status.toLowerCase() == statusAtASC.toLowerCase()) {
      return statusAtASCFor;
    } else if (status.toLowerCase() == statusWaitingForApproval.toLowerCase() || status.toLowerCase() == statusWaitingForApprovalBothSame.toLowerCase()) {
      return statusWaitingForApprovalFor;
    } else if (status.toLowerCase() == statusApproved.toLowerCase()) {
      return statusApprovedFor;
    } else if (status.toLowerCase() == statusRejected.toLowerCase()) {
      return statusRejectedFor;
    } else {
      return "-";
    }
  }

  int _btnId(String status) {
    if (status.toLowerCase() == statusProductPickedUp.toLowerCase()) {
      return 0;
    } else if (status.toLowerCase() == statusAtASC.toLowerCase()) {
      return 1;
    } else if (status.toLowerCase() == statusWaitingForApproval.toLowerCase()) {
      return -1;
    } else if (status.toLowerCase() == statusApproved.toLowerCase()) {
      return 2;
    } else if (status.toLowerCase() == statusRejected.toLowerCase()) {
      return 3;
    } else {
      return -1;
    }
  }

  @override
  build(BuildContext context) {
    return _scaffold();
  }

  _scaffold() => CommonScaffold(
        backGroundColor: Colors.white,
        appTitle: titleAscHoMobileList,
        showDrawer: false,
        showBottom: false,
        showAppBar: false,
        scaffoldKey: _scaffoldState,
        bodyData: Column(children: <Widget>[
          new IOSSearchBar(
            controller: _searchTextController,
            focusNode: _searchFocusNode,
            animation: _animation,
            onUpdate: _ascHoBloc.searchInput,
            onCancel: _cancelSearch,
            hintText: 'Search Mobile ASC/HO',
            onClear: _clearSearch,
          ),
          Expanded(child: _bodyData())
        ]),
      );

  @override
  void dispose() {
    if (this.mounted) super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
