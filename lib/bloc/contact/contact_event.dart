abstract class ContactEvent {}

class Contact extends ContactEvent {
  Function callback;
  Contact({this.callback});
}
