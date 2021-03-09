import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

Future<File> getImage(ImageSource imageSource) async {
  File image = await ImagePicker.pickImage(source: imageSource, imageQuality: 20);
  if (image != null && image.path != null) {
    return image;
  }
  return null;
}

List<String> getDateTime() {
  var nowDate = new DateTime.now();
  var patternDate = new DateFormat('yyyy-MM-dd');
  String formattedDate = patternDate.format(nowDate);

  DateTime nowTime = DateTime.now();
  String patternTime = DateFormat('kk:mma').format(nowTime);

  List<String> listValues = [formattedDate, patternTime];

  return listValues;
}
