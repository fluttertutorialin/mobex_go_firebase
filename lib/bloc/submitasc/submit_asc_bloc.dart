import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'submit_asc_event.dart';
import 'submit_asc_state.dart';

class SubmitAscBloc extends Bloc<SubmitAscEvent, SubmitAscState> {
  final ApiProvider apiProvider = ApiProvider();

  void mapParamInput(param) {
    dispatch(MapParamInput(param: param));
  }

  void submitAsc(callback) {
    dispatch(SubmitAsc(callback: callback));
  }

  void fileSelectedList(multipleUploadList) {
    dispatch(FileSelectedList(multipleUploadList: multipleUploadList));
  }

  void firebaseUpload(callback) {
    dispatch(FirebaseUpload(callback: callback));
  }

  @override
  SubmitAscState get initialState => SubmitAscState.initial();

  @override
  Stream<SubmitAscState> mapEventToState(SubmitAscEvent event) async* {
    if (event is MapParamInput) {
      yield currentState.copyWith(param: event.param);
    }

    if (event is FileSelectedList) {
      yield currentState.copyWith(multipleUploadList: event.multipleUploadList);
    }

    if (event is FirebaseUpload) {
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

    if (event is SubmitAsc) {
      yield currentState.copyWith(loading: true);
      await apiProvider.submitAsc(currentState.param);
      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(
            loading: false,
            error: {},
          );
          event.callback(response);
        } else {
          yield currentState.copyWith(
            loading: false,
            error: {
              "error": apiProvider.apiResult.errorMessage
            },
          );
          event.callback(apiProvider.apiResult.errorMessage);
        }
      } catch (e) {
        yield currentState.copyWith(
          loading: false,
          error: {"error": "Error, Something bad happened."},
        );
        event.callback('Error, Something bad happened.');
      }
    }
  }
}
