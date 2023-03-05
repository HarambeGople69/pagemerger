import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:myapp/database/db_helper.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';

import '../../controller/dashboard_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(10),
            vertical: ScreenUtil().setSp(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: OurElevatedButton(
                    title: "Logout",
                    function: () async {
                      Get.find<DashboardController>().changeIndexs(0);
                      await Hive.box<int>(DatabaseHelper.outerlayerDB)
                          .put("state", 1);
                      OurToast().showSuccessToast("Logged out");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
