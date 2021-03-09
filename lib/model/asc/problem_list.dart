class ProblemListResponse {
  double id;
  String problemName;
  String condType;
  double netRate;
  double condId;
  double pId;
  String operator;
  String enterValue = "";

  ProblemListResponse(
      {this.id,
        this.problemName,
        this.condType,
        this.netRate,
        this.condId,
        this.pId,
        this.operator,
        this.enterValue});

  ProblemListResponse.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    problemName = json['DISPNAME'];
    condType = json['CONDTYPE'];
    netRate = json['NETRATE'];
    condId = json['CONDID'];
    pId = json['PID'];
    operator = json['OPERATOR'];
  }

  ProblemListResponse copyWith({double enterValue}) {
    return ProblemListResponse(
      enterValue: enterValue ?? this.enterValue,
    );
  }
}
