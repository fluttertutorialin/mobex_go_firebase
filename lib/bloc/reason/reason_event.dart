abstract class ReasonEvent {}

class SelectDate extends ReasonEvent {
  final String selectDate;
  SelectDate({this.selectDate});
}

class SelectTime extends ReasonEvent {
  final String selectTime;
  SelectTime({this.selectTime});
}

class Reason extends ReasonEvent {
  Function callback;
  Reason({this.callback});
}
