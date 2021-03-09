import 'package:meta/meta.dart';
import 'package:mobex_go/model/multiple_upload.dart';

class SubmitEstimateState {
  final String jsonParam;
  final List<MultipleUpload> multipleUploadList;
  bool loading;
  bool loaded;

  SubmitEstimateState({
    @required this.jsonParam,
    this.multipleUploadList,
    bool loading,
    bool loaded,
  });

  factory SubmitEstimateState.initial() {
    return SubmitEstimateState(jsonParam: null,  multipleUploadList: List());
  }

  SubmitEstimateState copyWith(
      {bool loading, bool loaded, Map error, String jsonParam, List<MultipleUpload> multipleUploadList}) {
    return SubmitEstimateState(jsonParam: jsonParam ?? this.jsonParam,
        multipleUploadList: multipleUploadList ?? this.multipleUploadList
    );
  }
}
