import 'package:mobex_go/model/multiple_upload.dart';

class MultipleUploadState {
  List<MultipleUpload> multipleUploadList;
  MultipleUpload multipleUpload;
  String removeId;

  MultipleUploadState(
      {this.multipleUploadList,
      this.multipleUpload,
      this.removeId});

  factory MultipleUploadState.initial() {
    return MultipleUploadState(
        multipleUploadList: List<MultipleUpload>(),
        multipleUpload: null,
        removeId: null);
  }

  MultipleUploadState copyWith(
      {List<MultipleUpload> multipleUploadList,
      MultipleUpload multipleUpload,
      String removeId,
      String imageUploadJson}) {
    return MultipleUploadState(
        multipleUploadList: multipleUploadList ?? this.multipleUploadList,
        multipleUpload: multipleUpload ?? this.multipleUpload,
        removeId: removeId ?? this.removeId);
  }
}
