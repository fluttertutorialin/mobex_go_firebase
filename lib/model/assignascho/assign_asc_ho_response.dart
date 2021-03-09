class AssignAscHoResponse {
  final int inquiryNo;
  final String name;
  final String brand;
  final String mobile;
  final String address;
  final String model;
  final String pickUpDateTime;
  final String status;
  final String jobId;
  final String assign;
  final String estimate;

  const AssignAscHoResponse(
      {this.inquiryNo,
      this.name,
      this.brand,
      this.mobile,
      this.address,
      this.model,
      this.pickUpDateTime,
      this.status,
      this.jobId,
      this.assign,
      this.estimate});

  factory AssignAscHoResponse.fromJson(Map<String, dynamic> json) {
    return  AssignAscHoResponse(
        inquiryNo: json['INQUIRYNO'],
        name: json['NAME'],
        brand: json['BRAND'],
        mobile: json['MOBILENO'],
        address: json['ADDRESS'],
        model: json['MODEL'],
        pickUpDateTime: json['PICKUPDATETIME'],
        status: json['STATUS'],
        jobId: json['JOBID'],
        assign: json['ASSIGNTOPLACE'],
        estimate: json['ESTIMATE']);
  }

  AssignAscHoResponse copyWith(
      {int inquiryNo,
      String name,
      String brand,
      String mobile,
      String address,
      String model,
      String pickUpDateTime,
      String status,
      String jobId,
      String assign,
      String estimate}) {

    return  AssignAscHoResponse(
      inquiryNo: inquiryNo ?? this.inquiryNo,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      model: model ?? this.model,
      pickUpDateTime: pickUpDateTime ?? this.pickUpDateTime,
      status: status ?? this.status,
      jobId: jobId ?? this.jobId,
      assign: assign ?? this.assign,
      estimate: estimate ?? this.estimate,
    );
  }
}
