import 'package:meta/meta.dart';
import 'package:mobex_go/model/postpone/postpone_response.dart';

class PostPoneState {
  bool loading;
  String errorMessage;
  final String userId;
  final List<PostPoneResponse> postPoneList;

  PostPoneState(
      {@required this.loading,
      this.errorMessage,
      this.userId,
      this.postPoneList});

  factory PostPoneState.initial() {
    return PostPoneState(
        loading: false, errorMessage: '', userId: null, postPoneList: List());
  }

  PostPoneState copyWith(
      {bool loading,
      String errorMessage,
      String userId,
      List<PostPoneResponse> postPoneList}) {
    return PostPoneState(
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        userId: userId ?? this.userId,
        postPoneList: postPoneList ?? this.postPoneList);
  }
}
