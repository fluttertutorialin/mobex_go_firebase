import 'package:mobex_go/model/multiple_upload.dart';

abstract class MultipleUploadEvent {
}

class RemoveId extends MultipleUploadEvent {
  final String uId;
  RemoveId({this.uId});
}

class MultipleUploadRemove extends MultipleUploadEvent {
  final Function callback;
  MultipleUploadRemove({this.callback});
}

class MultipleUploadClear extends MultipleUploadEvent {
  final Function callback;
  MultipleUploadClear({this.callback});
}

class ASCImageUpload extends MultipleUploadEvent {
  final Function callback;
  ASCImageUpload({this.callback});
}

class MultipleUploadParam extends MultipleUploadEvent {
  final MultipleUpload multipleUploadParam;
  MultipleUploadParam({this.multipleUploadParam});
}

class MultipleUploadResult extends MultipleUploadEvent {
  Function callback;
  MultipleUploadResult({this.callback});
}
