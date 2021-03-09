abstract class AscHoEvent {}

class UserIdParam extends AscHoEvent {
  final String userIdParam;
  UserIdParam({this.userIdParam});
}

class SearchInput extends AscHoEvent {
  final String search;
  SearchInput({this.search});
}

class JobIdParam extends AscHoEvent {
  final String jobIdParam;
  JobIdParam({this.jobIdParam});
}

class AscHoRemove extends AscHoEvent {
  final Function callback;
  AscHoRemove({this.callback});
}

class AscHo extends AscHoEvent {
  Function callback;
  AscHo({this.callback});
}

class SubmitHo extends AscHoEvent {
  Function callback;
  SubmitHo({this.callback});
}

class AscStatusUpdate extends AscHoEvent {
  Function callback;
  AscStatusUpdate({this.callback});
}
