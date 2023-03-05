import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/screens/dashboard_screen/gallery_image_screen.dart';
import 'package:myapp/utils/color.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:myapp/widgets/our_password_field.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:myapp/widgets/our_text_field.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/login_controller.dart';
import '../../widgets/our_elevated_button.dart';
import '../../widgets/our_spinner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: Get.find<LoginController>().processing.value,
          progressIndicator: OurSpinner(),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setSp(10),
                    vertical: ScreenUtil().setSp(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setSp(7.5),
                            ),
                          ),
                          height: ScreenUtil().setSp(40),
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setSp(2.5),
                            left: ScreenUtil().setSp(10),
                            right: ScreenUtil().setSp(10),
                          ),
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setSp(10),
                            right: ScreenUtil().setSp(10),
                            left: ScreenUtil().setSp(10),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: ScreenUtil().setSp(12.5),
                              ),
                              Expanded(
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RotationTransition(
                                        turns: logoAnimation,
                                        child: Image.asset(
                                          "assets/images/logo.png",
                                          height: ScreenUtil().setSp(22.5),
                                          width: ScreenUtil().setSp(22.5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setSp(7.5),
                                      ),
                                      Text(
                                        "Page Merger",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(20.5),
                                          color: darklogoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Icon(
                                FeatherIcons.search,
                                color: logoColor,
                                size: ScreenUtil().setSp(22.5),
                              ),
                              SizedBox(
                                width: ScreenUtil().setSp(12.5),
                              ),
                              RotationTransition(
                                turns: bellAnimation,
                                child: Icon(
                                  FeatherIcons.bell,
                                  color: logoColor,
                                  size: ScreenUtil().setSp(22.5),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setSp(12.5),
                              ),
                            ],
                          ),
                        ),
                        OurSizedBox(),
                        OurElevatedButton(
                          title: "CONVERT TO PDF",
                          function: () {
                            chooseMode(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void chooseMode(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(10),
            vertical: ScreenUtil().setSp(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Text(
                  "Convert to PDF",
                  style: TextStyle(
                      color: darklogoColor,
                      fontSize: ScreenUtil().setSp(25),
                      fontWeight: FontWeight.w500),
                ),
              ),
              Divider(
                color: darklogoColor,
              ),
              OurSizedBox(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: GalleryImageOpener(),
                    ),
                  );
                  // GalleryImageOpener
                  print("Gallery Pressed");
                },
                child: Container(
                  child: Text(
                    "Gallery",
                    style: TextStyle(
                        color: darklogoColor,
                        fontSize: ScreenUtil().setSp(22.5),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              OurSizedBox(),
              Divider(
                color: darklogoColor,
              ),
              InkWell(
                onTap: () {
                  print("Camera Pressed");
                },
                child: Container(
                  child: Text(
                    "Camera",
                    style: TextStyle(
                        color: darklogoColor,
                        fontSize: ScreenUtil().setSp(22.5),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              OurSizedBox(),
            ],
          ),
        );
      },
    );
  }
}
