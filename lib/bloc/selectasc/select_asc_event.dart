abstract class SelectAscEvent {}

class SaveInquiryNo extends SelectAscEvent {
  final int inquiryNo;
  SaveInquiryNo({this.inquiryNo});
}

class SaveJobId extends SelectAscEvent {
  final String jobId;
  SaveJobId({this.jobId});
}

class SaveName extends SelectAscEvent {
  final String name;
  SaveName({this.name});
}

class SaveBrand extends SelectAscEvent {
  final String brand;
  SaveBrand({this.brand});
}

class SaveMobile extends SelectAscEvent {
  final String mobile;
  SaveMobile({this.mobile});
}

class SaveAddress extends SelectAscEvent {
  final String address;
  SaveAddress({this.address});
}

class SaveModel extends SelectAscEvent {
  final String model;
  SaveModel({this.model});
}
