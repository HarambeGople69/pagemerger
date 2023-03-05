import 'package:get/get.dart';

class ImageUrlController extends GetxController {
  RxList<String> imageUrls = <String>[].obs;
  initialize(){
    print("Hello World");
    imageUrls.value = <String>[];
  }
  void addData(List<String> dataList) {
    // imageUrls.value.clear();
    imageUrls.value.addAll(dataList);
    print("Utsav Shrestha");
    print(imageUrls.value);
    print(imageUrls.value.length);
  }
}
