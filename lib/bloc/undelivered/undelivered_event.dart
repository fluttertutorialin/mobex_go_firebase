abstract class UndeliveredEvent {}

class UserIdParam extends UndeliveredEvent {
  final String userIdParam;
  UserIdParam({this.userIdParam});
}

class InquiryNo extends UndeliveredEvent {
  final int inquiryNo;
  InquiryNo({this.inquiryNo});
}

class Undelivered extends UndeliveredEvent {
  Function callback;
  Undelivered({this.callback});
}
