import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';
import '../controller/image_urls_controller.dart';
import '../controller/login_controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
   
    Get.lazyPut(
      () => LoginController(),
    );
    Get.lazyPut(
      () => DashboardController(),
    );
    Get.lazyPut(
      () => ImageUrlController(),
    );
    // ImageUrlController
    // Get.lazyPut(
    //   () => SearchTextController(),
    // );
    // Get.lazyPut(
    //   () => QuantityController(),
    // );
    // Get.lazyPut(
    //   () => ChooseAddressController(),
    // );
    // Get.lazyPut(
    //   () => DeliveryTimeController(),
    // );

    // Get.lazyPut(
    //   () => OTPController(),
    // );
    // Get.lazyPut(
    //   () => ProductListName(),
    // );
    // Get.lazyPut(
    //   () => CategoryTagController(),
    // );
    // Get.lazyPut(
    //   () => AddItemController(),
    // );
    // Get.lazyPut(
    //   () => ShoppingListSearchController(),
    // );
    // Get.lazyPut(
    //   () => LatLongController(),
    // );
    // Get.lazyPut(
    //   () => ExploreShopController(),
    // );
    // Get.lazyPut(
    //   () => PolyLineController(),
    // );
    // Get.lazyPut(
    //   () => CheckOutScreenController(),
    // );
    // Get.lazyPut(
    //   () => MessageSendController(),
    // );
    // Get.lazyPut(
    //   () => CheckConnectivity(),
    // );
    // Get.lazyPut(
    //   () => MessageToggleScreenController(),
    // );
    // MessageToggleScreenController
    // CheckConnectivity
    // ShoppingListSearchController
    // ProductListName
    // PolyLineController
  }
}
