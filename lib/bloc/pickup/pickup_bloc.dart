import 'package:bloc/bloc.dart';
import 'package:mobex_go/model/pickup/pickup_response.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'pickup_event.dart';
import 'pickup_state.dart';

class PickUpBloc extends Bloc<PickUpEvent, PickUpState> {
  final ApiProvider apiProvider = ApiProvider();

  void userIdParam(userIdParam) {
    dispatch(UserIdParam(userIdParam: userIdParam));
    dispatch(PickUp());
  }

  void pickUpRemove(inquiryNo) {
    dispatch(InquiryNo(inquiryNo: inquiryNo));
    dispatch(PickUpRemove());
  }

  @override
  PickUpState get initialState => PickUpState.initial();

/*  @override
  Stream<PickUpState> transformEvents(Stream<PickUpEvent> events,
      Stream<PickUpState> Function(PickUpEvent event) next) {
    return super.transformEvents(
      (events as Observable<PickUpEvent>).debounceTime(
        Duration(milliseconds: 0),
      ),
      next,
    );
  }*/

  @override
  Stream<PickUpState> mapEventToState(PickUpEvent event) async* {
    if (event is UserIdParam) {
      yield currentState.copyWith(userId: event.userIdParam);
    }

    if (event is InquiryNo) {
      yield currentState.copyWith(inquiryNo: event.inquiryNo);
    }

    if (event is PickUpRemove) {
      List<PickUpResponse> removeInquiryNo = currentState.pickUpList;
      removeInquiryNo
          .removeWhere((item) => item.inquiryNo == currentState.inquiryNo);
      yield currentState.copyWith(inquiryNo: null, pickUpList: removeInquiryNo);
    }

    if (event is PickUp) {
      yield currentState.copyWith(pickUpList: List(), loading: true);
      await apiProvider.getPickUp(currentState.userId);

      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(loading: false, pickUpList: response);
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
