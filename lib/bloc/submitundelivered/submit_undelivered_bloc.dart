import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'submit_undelivered_event.dart';
import 'submit_undelivered_state.dart';

class SubmitUndeliveredBloc
    extends Bloc<SubmitUndeliveredEvent, SubmitUndeliveredState> {
  final ApiProvider apiProvider = ApiProvider();

  void mapParam(param) {
    dispatch(MapParamInput(param: param));
  }

  void reasonTitle(reasonTitle) {
    dispatch(ReasonTitle(reasonTitle: reasonTitle));
  }

  void title(title) {
    dispatch(Title(title: title));
  }

  void submit(callback) {
    dispatch(Submit(callback: callback));
  }

  void fileSelectedList(multipleUploadList) {
    dispatch(FileSelectedList(multipleUploadList: multipleUploadList));
  }

  void firebaseUploadInsertDb(callback) {
    dispatch(FirebaseUploadInsertDb(callback: callback));
  }

  @override
  SubmitUndeliveredState get initialState => SubmitUndeliveredState.initial();

  @override
  Stream<SubmitUndeliveredState> mapEventToState(
      SubmitUndeliveredEvent event) async* {
    if (event is MapParamInput) {
      yield currentState.copyWith(param: event.param);
    }

    if (event is ReasonTitle) {
      yield currentState.copyWith(reasonTitle: event.reasonTitle);
    }

    if (event is Title) {
      yield currentState.copyWith(title: event.title);
    }

    if (event is FileSelectedList) {
      yield currentState.copyWith(multipleUploadList: event.multipleUploadList);
    }

    if (event is FirebaseUploadInsertDb) {
      List<StorageUploadTask> _tasks = <StorageUploadTask>[];
      List<String> getUrlList = new List();
      StorageUploadTask uploadTask;

      for (var multipleUpload in currentState.multipleUploadList) {
        if (multipleUpload.uId != '0') {
          String ext = extension(multipleUpload.file.path);
          StorageReference storageRef = FirebaseStorage.instance.ref().child(
              "_" +
                  multipleUpload.imageType +
                  "_" +
                  multipleUpload.jobId +
                  "_" +
                  multipleUpload.bikerId +
                  "_" +
                  DateTime.now().millisecondsSinceEpoch.toString() +
                  "_" +
                  Uuid().v1() +
                  ext);
          uploadTask = storageRef.putFile(multipleUpload.file);
          _tasks.add(uploadTask);
        }
      }

      await uploadTask.onComplete;
      if (uploadTask.isComplete) {
        _tasks.forEach((StorageUploadTask task) async {
          final String url = await task.lastSnapshot.ref.getDownloadURL();
          getUrlList.add(url);
          if (getUrlList.length == currentState.multipleUploadList.length - 1) {
            event.callback(getUrlList);
          }
        });
      } else {
        event.callback(false);
      }
    }

    if (event is Submit) {
      await apiProvider.getPostPoneCancelReason(
          currentState.param, currentState.title, currentState.reasonTitle);
      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult;
          yield currentState.copyWith(
            error: {},
          );
          event.callback(response);
        } else {
          yield currentState.copyWith(
            error: {"error": apiProvider.apiResult.errorMessage},
          );
          event.callback(apiProvider.apiResult.errorMessage);
        }
      } catch (e) {
        yield currentState.copyWith(
          error: {"error": "Error, Something bad happened."},
        );
        event.callback('Error, Something bad happened.');
      }
    }
  }
}
