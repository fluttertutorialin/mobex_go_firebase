import 'package:meta/meta.dart';
import 'package:mobex_go/model/pickup/pickup_response.dart';

class PickUpState {
  bool loading;
  String errorMessage;
  final String userId;
  int inquiryNo;
  final List<PickUpResponse> pickUpList;

  PickUpState(
      {@required this.loading,
      this.errorMessage,
      this.userId,
      this.inquiryNo,
      this.pickUpList});

  factory PickUpState.initial() {
    return PickUpState(
        loading: false,
        errorMessage: '',
        userId: null,
        inquiryNo: null,
        pickUpList: List());
  }

  PickUpState copyWith(
      {bool loading,
      String errorMessage,
      String userId,
      int inquiryNo,
      Map<String, dynamic> param,
      String reasonTitle,
      String title,
      List<PickUpResponse> pickUpList}) {
    return PickUpState(
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        userId: userId ?? this.userId,
        inquiryNo: inquiryNo ?? this.inquiryNo,
        pickUpList: pickUpList ?? this.pickUpList);
  }
}
