abstract class AscEvent {}

class JobIdParam extends AscEvent {
  final String jobIdParam;
  JobIdParam({this.jobIdParam});
}

class TotalEstimate extends AscEvent {
  Function callback;
  TotalEstimate({this.callback});
}

class Asc extends AscEvent {
  Function callback;
  Asc({this.callback});
}
