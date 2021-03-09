import 'package:meta/meta.dart';
import 'package:mobex_go/model/assignascho/assign_asc_ho_response.dart';

class AscHoState {
  bool loading;
  String errorMessage;
  String search, userId, jobId;
  final List<AssignAscHoResponse> ascHoList;

  AscHoState({
    @required this.loading,
    this.errorMessage,
    this.search,
    this.userId,
    this.jobId,
    this.ascHoList,
  });

  factory AscHoState.initial() {
    return AscHoState(
        loading: false,
        errorMessage: '',
        search: null,
        userId: null,
        jobId: null,
        ascHoList: List<AssignAscHoResponse>());
  }

  AscHoState copyWith(
      {bool loading,
      String errorMessage,
      String search,
      String userId,
      String jobId,
      List<AssignAscHoResponse> ascHoList}) {
    return AscHoState(
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        search: search ?? this.search,
        userId: userId ?? this.userId,
        jobId: jobId ?? this.jobId,
        ascHoList: ascHoList ?? this.ascHoList);
  }
}
