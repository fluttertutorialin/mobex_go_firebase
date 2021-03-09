import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'submit_estimate_event.dart';
import 'submit_estimate_state.dart';

class SubmitEstimateBloc
    extends Bloc<SubmitEstimateEvent, SubmitEstimateState> {
  final ApiProvider apiProvider = ApiProvider();

  void jsonParam(jsonParam) {
    dispatch(JsonParamInput(jsonParam: jsonParam));
  }

  void submitEstimate(callback) {
    dispatch(SubmitEstimate(callback: callback));
  }

  void fileSelectedList(multipleUploadList) {
    dispatch(FileSelectedList(multipleUploadList: multipleUploadList));
  }

  void firebaseUpload(callback) {
    dispatch(FirebaseUpload(callback: callback));
  }

  @override
  SubmitEstimateState get initialState => SubmitEstimateState.initial();

  @override
  Stream<SubmitEstimateState> mapEventToState(
      SubmitEstimateEvent event) async* {
    if (event is JsonParamInput) {
      yield currentState.copyWith(jsonParam: event.jsonParam);
    }

    if (event is FileSelectedList) {
      yield currentState.copyWith(multipleUploadList: event.multipleUploadList);
    }

    if (event is FirebaseUpload) {}

    if (event is SubmitEstimate) {
      yield currentState.copyWith(loading: true);
      await apiProvider.createEstimate(currentState.jsonParam);
      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(
            loaded: true,
            loading: false,
            error: {},
          );
          event.callback(response);
        } else {
          yield currentState.copyWith(
            loaded: true,
            loading: false,
            error: {"error": apiProvider.apiResult.errorMessage},
          );
          event.callback(apiProvider.apiResult.errorMessage);
        }
      } catch (e) {
        yield currentState.copyWith(
          loaded: true,
          loading: false,
          error: {"error": "Error, Something bad happened."},
        );
        event.callback('Error, Something bad happened.');
      }
    }
  }
}
