class DispatchResponse
{
   final String jobId;
   final int lonerPhone;
   final String name;
   final String mobile;
   final String address;
   final String brand;
   final String model;
   final double codAmount;
   final String dispatchDateTime;
   final bool dispatchMobile;

   DispatchResponse({this.jobId, this.lonerPhone, this.name, this.mobile, this.address, this.brand, this.model, this.codAmount, this.dispatchDateTime, this.dispatchMobile});

   factory DispatchResponse.fromJson(Map<String, dynamic> json) {
      return   DispatchResponse(
         jobId: json['JOBID'],
         lonerPhone: json['LOANERPHONE'],
         name: json['NAME'],
         mobile: json['MOBILENO'],
         address: json['ADDRESS'],
         brand: json['BRAND'],
         model: json['MODEL'],
         codAmount: json['CODAMOUNT'],
         dispatchDateTime: json['DISPATCHDATETIME'],
         dispatchMobile: json['DISPATCHTO'],
      );
   }
}