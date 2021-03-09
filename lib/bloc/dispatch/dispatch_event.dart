abstract class DispatchEvent {}

class UserIdParam extends DispatchEvent {
  final String userIdParam;
  UserIdParam({this.userIdParam});
}

class JobId extends DispatchEvent {
  final String jobId;
  JobId({this.jobId});
}

class DispatchRemove extends DispatchEvent {
  final Function callback;
  DispatchRemove({this.callback});
}

class Dispatch extends DispatchEvent {
  Function callback;
  Dispatch({this.callback});
}
