import 'package:get/get.dart';


class AuthController extends GetxController{
  var docId = ''.obs;
  var docName = ''.obs;

  void setDoctorId(String id) {
    docId.value = id;
    // docName.value = name;
  }

  String get getdocId => docId.value;
}