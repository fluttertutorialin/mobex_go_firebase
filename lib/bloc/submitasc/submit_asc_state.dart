import 'package:meta/meta.dart';
import 'package:mobex_go/model/multiple_upload.dart';

class SubmitAscState {
  final Map<String, dynamic> param;
  final List<MultipleUpload> multipleUploadList;
  bool loading;

  SubmitAscState({
    @required this.param,
    @required this.multipleUploadList,
    bool loading,
  });

  factory SubmitAscState.initial() {
    return SubmitAscState(param: Map(), multipleUploadList: List());
  }

  SubmitAscState copyWith(
      {bool loading,
      Map error,
      Map<String, dynamic> param,
      List<MultipleUpload> multipleUploadList}) {
    return SubmitAscState(
        param: param ?? this.param,
        multipleUploadList: multipleUploadList ?? this.multipleUploadList);
  }
}
