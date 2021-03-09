import 'package:bloc/bloc.dart';
import 'package:mobex_go/service/viewmodel/contact_view_model.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  @override
  ContactState get initialState => ContactState.initial();

  void contact() {
    dispatch(Contact());
  }
  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is Contact) {
      yield currentState.copyWith(loading: true);
      final _contactVM = ContactViewModel();

      yield currentState.copyWith(
          loading: false, contactList: _contactVM.getContacts());
    } else {
      yield currentState.copyWith(
        loading: false,
      );
    }
  }
}
