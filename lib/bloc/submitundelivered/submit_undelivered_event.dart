import 'package:mobex_go/model/multiple_upload.dart';

abstract class SubmitUndeliveredEvent {}

class MapParamInput extends SubmitUndeliveredEvent {
  final Map<String, dynamic> param;
  MapParamInput({this.param});
}

class ReasonTitle extends SubmitUndeliveredEvent {
  final String reasonTitle;
  ReasonTitle({this.reasonTitle});
}

class Title extends SubmitUndeliveredEvent {
  final String title;
  Title({this.title});
}

class Submit extends SubmitUndeliveredEvent {
  Function callback;
  Submit({this.callback});
}

class FileSelectedList extends SubmitUndeliveredEvent {
  final List<MultipleUpload> multipleUploadList;
  FileSelectedList({this.multipleUploadList});
}

class FirebaseUploadInsertDb extends SubmitUndeliveredEvent {
  Function callback;
  FirebaseUploadInsertDb({this.callback});
}
