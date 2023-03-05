import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/controller/dashboard_controller.dart';
import 'package:myapp/screens/dashboard_screen/home_screen.dart';
import 'package:myapp/screens/dashboard_screen/profile_screen.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:myapp/widgets/our_password_field.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:myapp/widgets/our_text_field.dart';

import '../../controller/login_controller.dart';
import '../../utils/color.dart';
import '../../widgets/our_spinner.dart';

class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({super.key});

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen>
    with TickerProviderStateMixin {
  TextEditingController _phone_number_controller = TextEditingController();
  TextEditingController _user_controller = TextEditingController();
  TextEditingController _repassowrd_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  FocusNode _email_node = FocusNode();
  FocusNode _password_node = FocusNode();
  FocusNode _user_node = FocusNode();
  FocusNode _repassword_node = FocusNode();
  late Tween<Offset> offset;
  int tag = 0;
  late AnimationController animationController;
  late AnimationController logoanimationController;
  late Animation<double> bellAnimation;
  late Animation<double> logoAnimation;
  @override
  void dispose() {
    // TODO: implement dispose
    _phone_number_controller.clear();
    _phone_number_controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    animationController = AnimationController(
      duration: Duration(milliseconds: 900),
      vsync: this,
    );
    bellAnimation = Tween<double>(begin: -0.04, end: 0.04).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );

    logoAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );
    animationController.repeat(reverse: true);
  }

  List widgets = [
    HomeScreen(),
    Center(
      child: Text(
        "data 1",
      ),
    ),
    Center(
      child: Text("data 2"),
    ),
    Center(
      child: Text("data 3"),
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onHorizontalDragEnd: (dragDetail) {
            if (dragDetail.velocity.pixelsPerSecond.dx < 1) {
              if (Get.find<DashboardController>().indexs.value < 4) {
                print(Get.find<DashboardController>().indexs.value);
                print("Right swipe");
                Get.find<DashboardController>().changeIndexs(
                    Get.find<DashboardController>().indexs.value + 1);
              }
            } else {
              if (Get.find<DashboardController>().indexs.value > 0) {
                print(Get.find<DashboardController>().indexs.value);
                print("Left swipe");
                Get.find<DashboardController>().changeIndexs(
                    Get.find<DashboardController>().indexs.value - 1);
              }
            }
          },
          child: Scaffold(
            bottomNavigationBar: SnakeNavigationBar.color(
              height: ScreenUtil().setSp(50),
              behaviour: SnakeBarBehaviour.floating,
              snakeShape: SnakeShape.circle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    ScreenUtil().setSp(20),
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(20),
                vertical: ScreenUtil().setSp(10),
              ),
              snakeViewColor: logoColor.withOpacity(0.3),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.blueGrey,
              showUnselectedLabels: false,
              showSelectedLabels: true,
              currentIndex: Get.find<DashboardController>().indexs.value,
              onTap: (index) {
                Get.find<DashboardController>().changeIndexs(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    MdiIcons.storeOutline,
                    color: darklogoColor,
                    size: ScreenUtil().setSp(22.5),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    MdiIcons.magnify,
                    color: darklogoColor,
                    size: ScreenUtil().setSp(22.5),
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    // Icons.list_alt_outlined,
                    MdiIcons.chatOutline,
                    color: darklogoColor,
                    size: ScreenUtil().setSp(22.5),
                  ),
                  label: 'Messages',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    // Icons.list_alt_outlined,
                    MdiIcons.checkAll,
                    color: darklogoColor,
                    size: ScreenUtil().setSp(22.5),
                  ),
                  label: 'Messages',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      MdiIcons.accountOutline,
                      color: darklogoColor,
                      size: ScreenUtil().setSp(22.5),
                    ),
                    label: 'Profile')
              ],
              selectedLabelStyle: const TextStyle(fontSize: 14),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
            ),
            body: widgets[Get.find<DashboardController>().indexs.value],
          ),
        ));
  }
}
