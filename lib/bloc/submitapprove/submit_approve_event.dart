import 'package:mobex_go/model/multiple_upload.dart';

abstract class SubmitApproveEvent {}

class MapParamInput extends SubmitApproveEvent {
  final Map<String, dynamic> param;
  MapParamInput({this.param});
}

class SubmitApprove extends SubmitApproveEvent {
  Function callback;
  SubmitApprove({this.callback});
}

class FirebaseUpload extends SubmitApproveEvent {
  Function callback;
  FirebaseUpload({this.callback});
}

class FileSelectedList extends SubmitApproveEvent {
  final List<MultipleUpload> multipleUploadList;
  FileSelectedList({this.multipleUploadList});
}