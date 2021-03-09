import 'package:mobex_go/model/imageupload/image_upload.dart';

class PickUpParam {
  final String assignToPlace;
  final int inquiryNo;
  final String jobId;
  final String isLoanerPhone;
  final String bikerId;
  final String bikerName;
  final List<ImageUpload> imageUpload;

  PickUpParam(
      {this.assignToPlace,
      this.inquiryNo,
      this.jobId,
      this.isLoanerPhone,
      this.bikerId,
      this.bikerName,
      this.imageUpload});
}
