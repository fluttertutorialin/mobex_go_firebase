import 'asc_list.dart';
import 'problem_list.dart';

class AscResponse {
  List<AscListResponse> ascList;
  List<ProblemListResponse> problemList;

  AscResponse({this.ascList, this.problemList});

  AscResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table1'] != null) {
      ascList = new List<AscListResponse>();
      json['Table1'].forEach((v) {
        ascList.add(new AscListResponse.fromJson(v));
      });
    }
    if (json['Table2'] != null) {
      problemList = new List<ProblemListResponse>();
      json['Table2'].forEach((v) {
        problemList.add(new ProblemListResponse.fromJson(v));
      });
    }
  }
}
