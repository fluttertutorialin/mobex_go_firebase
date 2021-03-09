import 'package:bloc/bloc.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'reason_event.dart';
import 'reason_state.dart';

class ReasonBloc extends Bloc<ReasonEvent, ReasonState> {
  final ApiProvider apiProvider = ApiProvider();

  void selectDate(selectDate) {
    dispatch(SelectDate(selectDate: selectDate));
  }

  void selectTime(selectTime) {
    dispatch(SelectTime(selectTime: selectTime));
  }

  void reason() {
    dispatch(Reason());
  }

  @override
  ReasonState get initialState => ReasonState.initial();

  @override
  Stream<ReasonState> mapEventToState(ReasonEvent event) async* {
    if (event is SelectDate) {
      yield currentState.copyWith(selectDate: event.selectDate);
    }

    if (event is SelectTime) {
      yield currentState.copyWith(selectTime: event.selectTime);
    }

    if (event is Reason) {
      yield currentState.copyWith(loading: true);
      await apiProvider.getPostPonCancelReasonList();
      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(loading: false, reasonList: response);
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
