import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/database/db_helper.dart';
import 'package:myapp/screens/dashboard_screen/dashboard_screen.dart';
import 'package:myapp/screens/onboarding_screen/onboarding_screen.dart';

import '../authentication_screen/authentication_login_screen.dart';

class OuterLayerScreen extends StatefulWidget {
  const OuterLayerScreen({Key? key}) : super(key: key);

  @override
  State<OuterLayerScreen> createState() => _OuterLayerScreenState();
}

class _OuterLayerScreenState extends State<OuterLayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<int>(DatabaseHelper.outerlayerDB).listenable(),
        builder: (context, Box<int> boxs, child) {
          int value = boxs.get("state", defaultValue: 0)!;
          print("===========");
          print(value);
          print("===========");
          return value == 0
              ? OnboardingScreen()
              : value == 1
                  ? LoginScreen()
                  : DashboardMainScreen();
        },
      ),
    );
  }
}
