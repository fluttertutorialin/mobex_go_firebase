import 'package:mobex_go/model/imageupload/create_estimate_image_upload.dart';

import 'asc_give_charge.dart';

class CreateEstimateJson {
  final String bikeId;
  final double totalAmount;
  final String jobId;
  final List<ASCGiveCharge> listASCGiveCharge;
  final String logisticCharge, ascCharge;
  final List<CreateEstimateImageUpload> listCreateEstimateImageUpload;

  CreateEstimateJson(this.bikeId, this.totalAmount, this.jobId,
      this.listASCGiveCharge, this.logisticCharge, this.ascCharge, {this.listCreateEstimateImageUpload});

  CreateEstimateJson.fromJson(Map<String, dynamic> json)
      : bikeId = json['BIKERID'],
        listASCGiveCharge = json['ESTIENTRY'],
        totalAmount = json['TOTALAMOUNT'],
        jobId = json['JOBID'],
        logisticCharge = json['LOGICHRG'],
        ascCharge = json['ASCCHRG'],
        listCreateEstimateImageUpload = json['IMAGE'];

  Map<String, dynamic> toJson() => {
        'BIKERID': bikeId,
        'ESTIENTRY': listASCGiveCharge,
        'TOTALAMOUNT': totalAmount,
        'JOBID': jobId,
        'LOGICHRG': logisticCharge,
        'ASCCHRG': ascCharge,
        'IMAGE': listCreateEstimateImageUpload
      };
}
