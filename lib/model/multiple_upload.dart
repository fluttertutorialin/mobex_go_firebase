import 'dart:io';

class MultipleUpload {
  final String uId;
  final String bikerId;
  final String jobId;
  final File file;
  final String imageType;

  MultipleUpload({
    this.uId,
    this.bikerId,
    this.jobId,
    this.file,
    this.imageType,
  });

  MultipleUpload copyWith(
      {String uId,
      String file,
      String imageType,
      String bikerId,
      String jobId}) {
    return MultipleUpload(
      uId: uId ?? this.uId,
      bikerId: bikerId ?? this.bikerId,
      jobId: jobId ?? this.jobId,
      file: file ?? this.file,
      imageType: imageType ?? this.imageType,
    );
  }
}
