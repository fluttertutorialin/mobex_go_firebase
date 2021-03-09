import 'package:bloc/bloc.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'undelivered_event.dart';
import 'undelivered_state.dart';

class UndeliveredBloc extends Bloc<UndeliveredEvent, UndeliveredState> {
  final ApiProvider apiProvider = ApiProvider();

  void userIdParam(userIdParam) {
    dispatch(UserIdParam(userIdParam: userIdParam));
  }

  void undelivered() {
    dispatch(Undelivered());
  }

  @override
  UndeliveredState get initialState => UndeliveredState.initial();

  @override
  Stream<UndeliveredState> mapEventToState(UndeliveredEvent event) async* {
    if (event is UserIdParam) {
      yield currentState.copyWith(userId: event.userIdParam);
    }

    if (event is InquiryNo) {
      yield currentState.copyWith(inquiryNo: event.inquiryNo);
    }

    if (event is Undelivered) {
      yield currentState.copyWith(loading: true);
      await apiProvider.getUndeliveredReason();

      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(loading: false, undeliveredList: response);
        } else {
          yield currentState.copyWith(
            loading: false,
          );
        }
      } catch (e) {
        yield currentState.copyWith(
          loading: false,
        );
        event.callback('Error, Something bad happened.');
      }
    }
  }
}
