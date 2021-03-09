import 'package:bloc/bloc.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'postpone_event.dart';
import 'postpone_state.dart';

class PostPoneBloc extends Bloc<PostPoneEvent, PostPoneState> {
  final ApiProvider apiProvider = ApiProvider();

  void userIdParam(userIdParam) {
    dispatch(UserIdParam(userIdParam: userIdParam));
    dispatch(PostPone());
  }

  @override
  PostPoneState get initialState => PostPoneState.initial();

  @override
  Stream<PostPoneState> mapEventToState(PostPoneEvent event) async* {
    if (event is UserIdParam) {
      yield currentState.copyWith(userId: event.userIdParam);
    }

    if (event is PostPone) {
      yield currentState.copyWith(postPoneList: List(), loading: true);
      await apiProvider.getPostPone(currentState.userId);
      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(loading: false, postPoneList: response);
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
