import 'package:get/get.dart';

class FileNameController extends GetxController {
  RxString fileName = "".obs;

  changeFileName(String newFileName) {
    fileName.value = newFileName;
  }
}
