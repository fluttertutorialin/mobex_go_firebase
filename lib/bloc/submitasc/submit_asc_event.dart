import 'package:mobex_go/model/multiple_upload.dart';

abstract class SubmitAscEvent {}

class MapParamInput extends SubmitAscEvent {
  final Map<String, dynamic> param;
  MapParamInput({this.param});
}

class SubmitAsc extends SubmitAscEvent {
  Function callback;
  SubmitAsc({this.callback});
}

class FirebaseUpload extends SubmitAscEvent {
  Function callback;
  FirebaseUpload({this.callback});
}

class FileSelectedList extends SubmitAscEvent {
  final List<MultipleUpload> multipleUploadList;
  FileSelectedList({this.multipleUploadList});
}