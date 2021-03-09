abstract class PickUpEvent {
}

class UserIdParam extends PickUpEvent {
  final String userIdParam;
  UserIdParam({this.userIdParam});
}

class InquiryNo extends PickUpEvent {
  final int inquiryNo;
  InquiryNo({this.inquiryNo});
}

class PickUpRemove extends PickUpEvent {
  final Function callback;
  PickUpRemove({this.callback});
}

class PickUp extends PickUpEvent {
  Function callback;
  PickUp({this.callback});
}
