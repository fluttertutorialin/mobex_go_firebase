class ImageUpload {
  String image;
  String imageType;

  ImageUpload({this.image, this.imageType});

  ImageUpload.fromJson(Map<String, dynamic> json)
      : image = json['IMAGE'],
        imageType = json['IMAGETYPE'];

  Map<String, dynamic> toJson() => {
    'IMAGE': image,
    'IMAGETYPE': imageType
  };
}
