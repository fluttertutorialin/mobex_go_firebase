import 'package:mobex_go/model/multiple_upload.dart';

abstract class SubmitEstimateEvent {}

class JsonParamInput extends SubmitEstimateEvent {
  final String jsonParam;
  JsonParamInput({this.jsonParam});
}

class SubmitEstimate extends SubmitEstimateEvent {
  Function callback;
  SubmitEstimate({this.callback});
}

class FirebaseUpload extends SubmitEstimateEvent {
  Function callback;
  FirebaseUpload({this.callback});
}

class FileSelectedList extends SubmitEstimateEvent {
  final List<MultipleUpload> multipleUploadList;
  FileSelectedList({this.multipleUploadList});
}