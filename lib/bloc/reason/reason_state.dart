import 'package:meta/meta.dart';
import 'package:mobex_go/model/reason/reason.dart';

class ReasonState {
  bool loading;
  String selectDate;
  String selectTime;
  final List<ReasonResponse> reasonList;

  ReasonState(
      {@required this.loading,
      this.selectDate,
      this.selectTime,
      this.reasonList});

  factory ReasonState.initial() {
    return ReasonState(
        loading: false, selectDate: "", selectTime: "", reasonList: List());
  }

  ReasonState copyWith(
      {bool loading,
      String selectDate,
      String selectTime,
      List<ReasonResponse> reasonList}) {
    return ReasonState(
        loading: loading ?? this.loading,
        selectDate: selectDate ?? this.selectDate,
        selectTime: selectTime ?? this.selectTime,
        reasonList: reasonList ?? this.reasonList);
  }
}
