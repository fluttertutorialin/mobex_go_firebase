import 'dart:async';
import 'package:bloc/bloc.dart';
import 'select_asc_event.dart';
import 'select_asc_state.dart';

class SelectAscBloc extends Bloc<SelectAscEvent, SelectAscState> {

  void saveInquiryNo(inquiryNo) {
    dispatch(SaveInquiryNo(inquiryNo: inquiryNo));
  }

  void saveJobId(jobId) {
    dispatch(SaveJobId(jobId: jobId));
  }

  void saveName(name) {
    dispatch(SaveName(name: name));
  }

  void saveBrand(brand) {
    dispatch(SaveBrand(brand: brand));
  }

  void saveMobile(mobile) {
    dispatch(SaveMobile(mobile: mobile));
  }

  void saveAddress(address) {
    dispatch(SaveAddress(address: address));
  }

  void saveModel(model) {
    dispatch(SaveModel(model: model));
  }

  @override
  SelectAscState get initialState => SelectAscState.initial();

  @override
  Stream<SelectAscState> mapEventToState(
    SelectAscEvent event,
  ) async* {
    if (event is SaveInquiryNo) {
      yield currentState.copyWith(inquiryNo: event.inquiryNo);
    }

    if (event is SaveJobId) {
      yield currentState.copyWith(jobId: event.jobId);
    }

    if (event is SaveName) {
      yield currentState.copyWith(name: event.name);
    }

    if (event is SaveBrand) {
      yield currentState.copyWith(brand: event.brand);
    }

    if (event is SaveMobile) {
      yield currentState.copyWith(mobile: event.mobile);
    }

    if (event is SaveAddress) {
      yield currentState.copyWith(address: event.address);
    }

    if (event is SaveModel) {
      yield currentState.copyWith(model: event.model);
    }
  }
}
