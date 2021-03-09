import 'package:meta/meta.dart';
import 'package:mobex_go/model/contact/contact_response.dart';

class ContactState {
  bool loading;
  final List<ContactResponse> contactList;

  ContactState({
    @required this.loading,
    this.contactList,
  });

  factory ContactState.initial() {
    return ContactState(loading: false, contactList: List<ContactResponse>());
  }

  ContactState copyWith({bool loading, List<ContactResponse> contactList}) {
    return ContactState(
        loading: loading ?? this.loading,
        contactList: contactList ?? this.contactList);
  }
}
