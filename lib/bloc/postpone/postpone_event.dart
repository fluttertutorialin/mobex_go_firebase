abstract class PostPoneEvent {}

class UserIdParam extends PostPoneEvent {
  final String userIdParam;
  UserIdParam({this.userIdParam});
}

class PostPone extends PostPoneEvent {
  Function callback;
  PostPone({this.callback});
}
