import 'package:mobex_go/model/multiple_upload.dart';

class SubmitUndeliveredState {
  Map<String, dynamic> param;
  List<MultipleUpload> multipleUploadList;
  String reasonTitle;
  String title;

  SubmitUndeliveredState({
    this.param,
    this.multipleUploadList,
    bool loading,
    bool loaded,
    this.reasonTitle,
    this.title,
  });

  factory SubmitUndeliveredState.initial() {
    return SubmitUndeliveredState(
        param: Map(),
        multipleUploadList: List(),
        reasonTitle: null,
        title: null);
  }

  SubmitUndeliveredState copyWith(
      {Map error,
      Map<String, dynamic> param,
      List<MultipleUpload> multipleUploadList,
      String reasonTitle,
      String title}) {
    return SubmitUndeliveredState(
        param: param ?? this.param,
        multipleUploadList: multipleUploadList ?? this.multipleUploadList,
        reasonTitle: reasonTitle ?? this.reasonTitle,
        title: title ?? this.title);
  }
}
