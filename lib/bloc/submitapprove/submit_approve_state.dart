import 'package:meta/meta.dart';
import 'package:mobex_go/model/multiple_upload.dart';

class SubmitApproveState {
  final Map<String, dynamic> param;
  final List<MultipleUpload> multipleUploadList;
  bool loading;
  bool loaded;

  SubmitApproveState({
    @required this.param,
    @required this.multipleUploadList,
    bool loading,
    bool loaded,
  });

  factory SubmitApproveState.initial() {
    return SubmitApproveState(param: Map(), multipleUploadList: List());
  }

  SubmitApproveState copyWith(
      {bool loading,
      bool loaded,
      Map error,
      Map<String, dynamic> param,
      List<MultipleUpload> multipleUploadList}) {
    return SubmitApproveState(
        param: param ?? this.param,
        multipleUploadList: multipleUploadList ?? this.multipleUploadList);
  }
}
