import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/dispatch/dispatch_bloc.dart';
import 'package:mobex_go/bloc/submitundelivered/submit_undelivered_bloc.dart';
import 'package:mobex_go/bloc/undelivered/undelivered_bloc.dart';
import 'package:mobex_go/bloc/undelivered/undelivered_state.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';
import 'package:mobex_go/model/reason/reason.dart';
import 'package:mobex_go/service/network_service_response.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/ui/widget/custom_float_form.dart';
import 'package:mobex_go/utils/vars.dart';

class PostPoneUndeliveredReasonPage extends StatefulWidget {
  final title, reasonName;
  final DispatchResponse dispatchResponse;

  PostPoneUndeliveredReasonPage(
      {this.title, this.reasonName, this.dispatchResponse});

  createState() =>
      PostPoneUndeliveredReasonState(title, reasonName, dispatchResponse);
}

class PostPoneUndeliveredReasonState
    extends State<PostPoneUndeliveredReasonPage> {
  String reasonDescription;

  PostPoneUndeliveredReasonState(
      String title, String reasonName, DispatchResponse dispatchResponse);

  UndeliveredBloc _undeliveredBloc;
  SubmitUndeliveredBloc _submitUndeliveredBloc;
  DispatchBloc _dispatchBloc;

  @override
  void initState() {
    super.initState();

    _undeliveredBloc = BlocProvider.of<UndeliveredBloc>(context);
    _submitUndeliveredBloc = BlocProvider.of<SubmitUndeliveredBloc>(context);
    _dispatchBloc = BlocProvider.of<DispatchBloc>(context);

    _undeliveredBloc.undelivered();
  }

  @override
  Widget build(BuildContext context) => _scaffold();

  _bodyData() => BlocBuilder(
      bloc: _undeliveredBloc,
      builder: (context, UndeliveredState snapshot) => snapshot.loading
          ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorProgressBar)),
            )
          : snapshot.undeliveredList.isEmpty
              ? Container(
                  child: Center(
                      child: (Text(msgNoData,
                          style: TextStyle(
                              color: colorNoData,
                              fontSize: 20,
                              fontFamily: quickFont)))))
              : _bodyList(snapshot.undeliveredList));

  dateTimePicker() => Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 0.0),
                    child: Text(
                      labelSelectReason + widget.reasonName.toLowerCase(),
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontFamily: quickFont),
                    )),
                Container(
                  color: Colors.grey,
                  width: 24.0,
                  height: 1.5,
                )
              ])
        ])
      ]));

  _bodyList(List<ReasonResponse> undeliveredReasonList) =>
      Column(children: <Widget>[
        titleHeader(),
        dateTimePicker(),
        Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: undeliveredReasonList.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                      splashColor: Colors.black12,
                      onTap: () {
                        setState(() {
                          undeliveredReasonList
                              .forEach((element) => element.isSelected = false);
                          undeliveredReasonList[index].isSelected = true;
                          reasonDescription =
                              undeliveredReasonList[index].reasonName;
                        });
                      },
                      child: ReasonItem(undeliveredReasonList[index]),
                    ))),
        Container(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomFloatForm(
                    icon: Icons.done,
                    isMini: true,
                    qrCallback: () {
                      if (reasonDescription != null) {
                        Map<String, dynamic> param = {
                          jobNoParam: widget.dispatchResponse.jobId,
                          returnReasonNameParam: reasonDescription
                        };

                        _submitUndeliveredBloc.title(widget.title);
                        _submitUndeliveredBloc.reasonTitle(widget.reasonName);

                        _submitUndeliveredBloc.mapParam(param);
                        _submitUndelivered();
                      } else {
                        toast(
                            context,
                            labelSelectReason +
                                widget.reasonName.toLowerCase());
                      }
                    })))
      ]);

  _submitUndelivered() {
    showProgress(context);
    _submitUndeliveredBloc.submit((results) {
      if (results is NetworkServiceResponse) {
        hideProgress(context);
        NetworkServiceResponse apiResponse = results;
        if (apiResponse.responseCode == ok200) {
          _dispatchBloc.jobIdRemove(widget.dispatchResponse.jobId);
          _dispatchBloc.dispose();

          Navigator.pop(context);
        }
      } else {
        NetworkServiceResponse apiResponse = results;
        toast(context, apiResponse.errorMessage);
        hideProgress(context);
      }
    });
  }

  titleHeader() => Column(children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          titleReturnMobile,
          style: TextStyle(
              fontFamily: quickFont,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        SizedBox(height: 5.0)
      ]);

  Widget _scaffold() => CommonScaffold(
      appTitle: StringUtils.capitalize(widget.reasonName),
      bodyData: _bodyData(),
      actionFirstIcon: null);
}

class ReasonItem extends StatelessWidget {
  final ReasonResponse reasonResponse;

  ReasonItem(this.reasonResponse);

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.all(12.0),
      child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Container(
          child: Icon(
              reasonResponse.isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: reasonResponse.isSelected ? Colors.deepOrangeAccent : Colors.black),
        ),

        /*  Container(
            height: 25.0,
            width: 34.0,
            child: new Center(
              child: new Text(reasonResponse.id.toString(),
                  style: new TextStyle(
                      color: reasonResponse.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0)),
            ),
            decoration: new BoxDecoration(
              color: reasonResponse.isSelected ? Colors.blueAccent : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: reasonResponse.isSelected ? Colors.blueAccent : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),*/

        Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(reasonResponse.reasonName,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: quickFont,
                  color:
                      reasonResponse.isSelected ? Colors.deepOrangeAccent : Colors.black,
                )))
      ]));
}
