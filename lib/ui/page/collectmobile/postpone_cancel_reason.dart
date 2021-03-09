import 'package:basic_utils/basic_utils.dart';
import 'package:mobex_go/bloc/dispatch/dispatch_bloc.dart';
import 'package:mobex_go/bloc/pickup/pickup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobex_go/bloc/reason/reason_bloc.dart';
import 'package:mobex_go/bloc/reason/reason_state.dart';
import 'package:mobex_go/bloc/submitundelivered/submit_undelivered_bloc.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';
import 'package:mobex_go/model/pickup/pickup_response.dart';
import 'package:mobex_go/model/reason/reason.dart';
import 'package:mobex_go/service/network_service_response.dart';
import 'package:mobex_go/ui/widget/common_scaffold.dart';
import 'package:mobex_go/ui/widget/custom_float_form.dart';
import 'package:mobex_go/utils/vars.dart';

class PostPoneCancelReasonPage extends StatefulWidget {
  final title, reasonName;
  final DispatchResponse dispatchResponse;
  final PickUpResponse pickUpResponse;

  PostPoneCancelReasonPage(
      {this.title,
      this.reasonName,
      this.dispatchResponse,
      this.pickUpResponse});

  createState() => _PostPoneReasonCancelPageState(
      title, reasonName, dispatchResponse, pickUpResponse);
}

class _PostPoneReasonCancelPageState extends State<PostPoneCancelReasonPage> {
  String formattedDate, patternTime, time24Hour, reasonDescription;

  ReasonBloc _reasonBloc;
  SubmitUndeliveredBloc _submitUndeliveredBloc;
  DispatchBloc _dispatchBloc;
  PickUpBloc _pickUpBlock;

  _PostPoneReasonCancelPageState(String title, String reasonName,
      DispatchResponse dispatchResponse, PickUpResponse pickUpResponse);

  @override
  void initState() {
    super.initState();

    _reasonBloc = BlocProvider.of<ReasonBloc>(context);
    _submitUndeliveredBloc = BlocProvider.of<SubmitUndeliveredBloc>(context);
    _dispatchBloc = BlocProvider.of<DispatchBloc>(context);
    _pickUpBlock = BlocProvider.of<PickUpBloc>(context);

    _reasonBloc.reason();

    var nowDate =  DateTime.now();
    var patternDate =  DateFormat('yyyy-MM-dd');
    formattedDate = patternDate.format(nowDate);

    DateTime nowTime = DateTime.now();
    patternTime = DateFormat('kk:mma').format(nowTime);

    int time12Add = int.parse(DateFormat('kk').format(nowTime));
    time24Hour = time12Add.toString() + ":" + DateFormat('mm').format(nowTime);

    _reasonBloc.selectTime(patternTime);
    _reasonBloc.selectDate(formattedDate);
  }

  @override
  Widget build(BuildContext context) => _scaffold();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime _datePicked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate:  DateTime.now().subtract( Duration(days: 1)),
        lastDate:  DateTime.now().add( Duration(days: 30)));

    if (_datePicked != null) {
      formattedDate = _datePicked.year.toString() +
          "-" +
          _datePicked.month.toString() +
          "-" +
          _datePicked.day.toString();
      _reasonBloc.selectDate(patternTime);
    }
  }

  Future<Null> _selectTime() async {
    final TimeOfDay _timePicked = await showTimePicker(
      context: context,
      initialTime:  TimeOfDay.now(),
    );
    if (_timePicked != null) {
      if (_timePicked.hour.toString() == "0" &&
          _timePicked.period
                  .toString()
                  .replaceAll("DayPeriod.", "")
                  .toUpperCase() ==
              "AM") {
        patternTime = "24:" +
            _timePicked.minute.toString() +
            _timePicked.period
                .toString()
                .replaceAll("DayPeriod.", "")
                .toUpperCase();

        time24Hour = "24" + ":" + _timePicked.minute.toString();
        _reasonBloc.selectTime(patternTime);
      } else {
        int time12Add = _timePicked.hour;

        patternTime = _timePicked.hour.toString() +
            ":" +
            _timePicked.minute.toString() +
            _timePicked.period
                .toString()
                .replaceAll("DayPeriod.", "")
                .toUpperCase();

        time24Hour = time12Add.toString() + ":" + _timePicked.minute.toString();
        _reasonBloc.selectTime(patternTime);
      }
    }
  }

  bodyData() => BlocBuilder(
      bloc: _reasonBloc,
      builder: (context, ReasonState snapshot) => snapshot.loading
          ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                  valueColor:
                       AlwaysStoppedAnimation<Color>(colorProgressBar)),
            )
          : _bodyList(snapshot.reasonList));

  _bodyList(List<ReasonResponse> reasonList) => Column(children: <Widget>[
        titleHeader(),
        dateTimePicker(),
         Expanded(
            child:  ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: reasonList.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                      splashColor: Colors.black12,
                      onTap: () {
                        setState(() {
                          reasonList
                              .forEach((element) => element.isSelected = false);
                          reasonList[index].isSelected = true;

                          reasonDescription = reasonList[index].reasonName;
                        });
                      },
                      child:  ReasonItem(reasonList[index]),
                    ))),
        Container(
            child: Container(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomFloatForm(
                        icon: Icons.done,
                        isMini: true,
                        qrCallback: () {
                          if (reasonDescription != null) {
                            Map<String, dynamic> param = {
                              widget.title == tabDispatch
                                  ? jobIdParam
                                  : inquiryNoParam: widget.title ==
                                      tabDispatch
                                  ? widget.dispatchResponse.jobId
                                  : widget.pickUpResponse.inquiryNo.toString(),
                              postponeReasonParam: reasonDescription,
                              postponeDateParam: formattedDate,
                              postponeTimeParam: time24Hour.toUpperCase()
                            };

                            _submitUndeliveredBloc.title(widget.title);
                            _submitUndeliveredBloc
                                .reasonTitle(widget.reasonName);
                            _submitUndeliveredBloc.mapParam(param);
                            _submitUndelivered();
                          } else {
                            toast(
                                context,
                                labelSelectReason +
                                    widget.reasonName.toLowerCase());
                          }
                        }))))
      ]);

  _submitUndelivered() {
    showProgress(context);
    _submitUndeliveredBloc.submit((results) {
      if (results is NetworkServiceResponse) {
        hideProgress(context);
        NetworkServiceResponse apiResponse = results;
        if (apiResponse.responseCode == ok200) {
          if (widget.title == tabDispatch) {
            _dispatchBloc.jobIdRemove(widget.dispatchResponse.jobId);
          } else {
            _pickUpBlock.pickUpRemove(widget.pickUpResponse.inquiryNo);
          }
          Navigator.pop(context);
        }
      } else {
        NetworkServiceResponse apiResponse = results;
        toast(context, apiResponse.errorMessage);
        hideProgress(context);
      }
    });
  }

  dateTimePicker() => Container(
      margin: const EdgeInsets.all(12.0),
      child:  Column(children: <Widget>[
        widget.reasonName == btnCancel
            ? Container()
            : new Row(children: <Widget>[
                expandStyle(
                    1,
                     InkWell(
                        onTap: () {
                          if (widget.reasonName != "CANCEL") {
                            _selectDate(context);
                          }
                        },
                        child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                               Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (widget.reasonName != "CANCEL") {
                                          _selectDate(context);
                                        }
                                      },
                                      child: Text(
                                        '$labelSelectDate',
                                        style:  TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.blueGrey,
                                            fontFamily: quickFont)
                                      ))),
                               Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  child: Text(
                                    _reasonBloc.currentState.selectDate,
                                    style:  TextStyle(fontFamily: quickFont,
                                        fontSize: 17.0, color: Colors.black),
                                  )),
                            ]))),
                 Container(
                  margin: EdgeInsets.all(10.0),
                  color: Colors.grey,
                  width: 1.5,
                  height: 50.0,
                ),
                expandStyle(
                    1,
                     InkWell(
                        onTap: () {
                          if (widget.reasonName != "CANCEL") {
                            _selectTime();
                          }
                        },
                        child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                               Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  child: Text(
                                    labelSelectTime,
                                    style:  TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.blueGrey,
                                        fontFamily: quickFont)
                                  )),
                               Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  child: Text(
                                    _reasonBloc.currentState.selectTime,
                                    style:  TextStyle(fontFamily: quickFont,
                                        fontSize: 17.0, color: Colors.black),
                                  ))
                            ])))
              ]),
         Row(children: <Widget>[
           Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 0.0),
                    child: Text(
                      '$labelSelectReason' + widget.reasonName.toLowerCase(),
                      style:  TextStyle(
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

  titleHeader() => Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              widget.reasonName == btnCancel
                  ? widget.title.toUpperCase() + ' ' + btnCancel
                  : 'NEXT APPOINMENT ' + widget.title.toUpperCase(),
              style: TextStyle(
                  fontFamily: quickFont,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 5.0,
            )
          ]);

  Widget _scaffold() => CommonScaffold(
      appTitle: StringUtils.capitalize(widget.reasonName),
      bodyData: bodyData(),
    actionFirstIcon: null);
}

class ReasonItem extends StatelessWidget {
  final ReasonResponse reasonResponse;

  ReasonItem(this.reasonResponse);

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.all(10.0),
      child:  Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
         Container(
          child: Icon(
              reasonResponse.isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: reasonResponse.isSelected ? Colors.deepOrangeAccent : Colors.black),
        ),
        /*new Container(
            height: 25.0,
            width: 34.0,
            child:  Center(
              child:  Text(_item.id.toString(),
                  style:  TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0)),
            ),
            decoration:  BoxDecoration(
              color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
              border:  Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.blueAccent : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),*/
         Container(
            margin:  EdgeInsets.only(left: 10.0),
            child:  Text(reasonResponse.reasonName,
                style:  TextStyle(
                  fontSize: 13,
                  fontFamily: quickFont,
                  color:
                      reasonResponse.isSelected ? Colors.deepOrangeAccent : Colors.black,
                )))
      ]));
}
