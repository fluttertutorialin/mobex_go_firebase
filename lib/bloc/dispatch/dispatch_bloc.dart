import 'package:bloc/bloc.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'dispatch_event.dart';
import 'dispatch_state.dart';

class DispatchBloc extends Bloc<DispatchEvent, DispatchState> {
  final ApiProvider apiProvider = ApiProvider();

  void userIdParam(userIdParam) {
    dispatch(UserIdParam(userIdParam: userIdParam));
    dispatch(Dispatch());
  }

  void jobIdRemove(jobId) {
    dispatch(JobId(jobId: jobId));
    dispatch(DispatchRemove());
  }

  @override
  DispatchState get initialState => DispatchState.initial();

  @override
  Stream<DispatchState> mapEventToState(DispatchEvent event) async* {
    if (event is UserIdParam) {
      yield currentState.copyWith(userId: event.userIdParam);
    }

    if (event is JobId) {
      yield currentState.copyWith(jobId: event.jobId);
    }

    if (event is DispatchRemove) {
      List<DispatchResponse> removeJobId = currentState.dispatchList;
      removeJobId.removeWhere((item) => item.jobId == currentState.jobId);
      yield currentState.copyWith(jobId: null, dispatchList: removeJobId);
    }

    if (event is Dispatch) {
      yield currentState.copyWith(dispatchList: List(), loading: true);
      await apiProvider.getDispatch(currentState.userId);

      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(loading: false, dispatchList: response);
        } else {
          yield currentState.copyWith(
              loading: false, errorMessage: apiProvider.apiResult.errorMessage);
        }
      } catch (e) {
        yield currentState.copyWith(loading: false, errorMessage: e.toString());
        event.callback('Error, Something bad happened.');
      }
    }
  }
}
