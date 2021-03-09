class CreateEstimateImageUpload {
  String jobId;
  String userId;
  String userName;
  String image;
  String imageType;

  CreateEstimateImageUpload({this.jobId, this.userId, this.userName, this.image, this.imageType});

  CreateEstimateImageUpload.fromJson(Map<String, dynamic> json)
      : jobId = json['JOBID'],
        userId = json['BIKERID'],
        userName = json['BIKERNAME'],
        image = json['IMAGE'],
        imageType = json['IMAGETYPE'];

  Map<String, dynamic> toJson() => {
    'JOBID': jobId,
    'BIKERID': userId,
    'BIKERNAME': userName,
    'IMAGE': image,
    'IMAGETYPE': imageType
  };
}
