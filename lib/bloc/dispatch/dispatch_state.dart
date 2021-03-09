import 'package:meta/meta.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';

class DispatchState {
  bool loading;
  String errorMessage;
  final String userId;
  String jobId;
  Map<String, dynamic> param;
  String reasonTitle;
  String title;
  final List<DispatchResponse> dispatchList;

  DispatchState(
      {@required this.loading,
        this.errorMessage,
      this.userId,
      this.param,
      this.jobId,
      this.reasonTitle,
      this.title,
      this.dispatchList});

  factory DispatchState.initial() {
    return DispatchState(
        loading: false,
        errorMessage: '',
        userId: null,
        jobId: null,
        param: Map(),
        reasonTitle: null,
        title: null,
        dispatchList: List());
  }

  DispatchState copyWith(
      {bool loading,
        String errorMessage,
      String userId,
      String jobId,
      Map<String, dynamic> param,
      String reasonTitle,
      String title,
      List<DispatchResponse> dispatchList}) {
    return DispatchState(
        loading: loading ?? this.loading,
        errorMessage: errorMessage?? this.errorMessage,
        userId: userId ?? this.userId,
        jobId: jobId ?? this.jobId,
        param: param ?? this.param,
        reasonTitle: reasonTitle ?? this.reasonTitle,
        title: title ?? this.title,
        dispatchList: dispatchList ?? this.dispatchList);
  }
}
