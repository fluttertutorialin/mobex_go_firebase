import 'package:meta/meta.dart';
import 'package:mobex_go/model/asc/asc_list.dart';
import 'package:mobex_go/model/asc/problem_list.dart';

class AscState {
  bool loading;
  String errorMessage;
  String jobId;
  final List<AscListResponse> ascList;
  final List<ProblemListResponse> problemList;
  final double totalEstimate;
  List<String> selectPcbSubPcb;
  final bool mustServiceCharge;

  AscState({
    @required this.loading,
    this.errorMessage,
    this.jobId,
    this.ascList,
    this.problemList,
    this.totalEstimate,
    this.selectPcbSubPcb,
    this.mustServiceCharge,
  });

  factory AscState.initial() {
    return AscState(
        loading: false,
        errorMessage: '',
        jobId: null,
        ascList: List(),
        problemList: List(),
        totalEstimate: 0.0,
        selectPcbSubPcb: List(),
        mustServiceCharge: false);
  }

  AscState copyWith(
      {bool loading,
        String errorMessage,
      String jobId,
      List<AscListResponse> ascList,
      List<ProblemListResponse> problemList,
      double totalEstimate,
      List<String> selectPcbSubPcb,
      bool mustServiceCharge}) {
    return AscState(
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        jobId: jobId ?? this.jobId,
        ascList: ascList ?? this.ascList,
        problemList: problemList ?? this.problemList,
        totalEstimate: totalEstimate ?? this.totalEstimate,
        selectPcbSubPcb: selectPcbSubPcb ?? this.selectPcbSubPcb,
        mustServiceCharge: mustServiceCharge ?? this.mustServiceCharge);
  }
}
