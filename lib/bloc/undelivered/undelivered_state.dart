import 'package:meta/meta.dart';
import 'package:mobex_go/model/reason/reason.dart';

class UndeliveredState {
  bool loading;
  final String userId;
  int inquiryNo;
  final List<ReasonResponse> undeliveredList;

  UndeliveredState(
      {@required this.loading,
      this.userId,
      this.inquiryNo,
      this.undeliveredList});

  factory UndeliveredState.initial() {
    return UndeliveredState(
        loading: false,
        userId: null,
        inquiryNo: null,
        undeliveredList: List());
  }

  UndeliveredState copyWith(
      {bool loading,
      String userId,
      int inquiryNo,
      Map<String, dynamic> param,
      String reasonTitle,
      String title,
      List<ReasonResponse> undeliveredList}) {
    return UndeliveredState(
        loading: loading ?? this.loading,
        userId: userId ?? this.userId,
        inquiryNo: inquiryNo ?? this.inquiryNo,
        undeliveredList: undeliveredList ?? this.undeliveredList);
  }
}
