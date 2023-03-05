/*
* File : Shopping Login
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/utils/color.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/login_controller.dart';
import '../../widgets/our_flutter_toast.dart';
import '../../widgets/our_password_field.dart';
import '../../widgets/our_sized_box.dart';
import '../../widgets/our_spinner.dart';
import '../../widgets/our_text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _phone_number_controller = TextEditingController();
  TextEditingController _user_controller = TextEditingController();
  TextEditingController _repassowrd_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  FocusNode _email_node = FocusNode();
  FocusNode _password_node = FocusNode();
  FocusNode _user_node = FocusNode();
  FocusNode _repassword_node = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    _phone_number_controller.clear();
    _phone_number_controller.dispose();
    super.dispose();
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        OurSizedBox(),
                        Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.contain,
                          height: ScreenUtil().setSp(200),
                          width: ScreenUtil().setSp(200),
                        ),
                        OurSizedBox(),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(27.5),
                            color: darklogoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        OurSizedBox(),
                        OurSizedBox(),
                        OurSizedBox(),
                        CustomTextField(
                          start: _user_node,
                          end: _email_node,
                          icon: Icons.person,
                          letterlength: 100,
                          controller: _user_controller,
                          validator: (value) {},
                          title: "Username",
                          type: TextInputType.emailAddress,
                          number: 0,
                        ),
                        OurSizedBox(),
                        CustomTextField(
                          start: _email_node,
                          end: _password_node,
                          icon: Icons.email,
                          letterlength: 100,
                          controller: _email_controller,
                          validator: (value) {},
                          title: "Username",
                          type: TextInputType.emailAddress,
                          number: 0,
                        ),
                        OurSizedBox(),
                        PasswordForm(
                          start: _password_node,
                          end: _repassword_node,
                          title: "Password",
                          controller: _password_controller,
                          validator: (value) {},
                          number: 0,
                        ),
                        OurSizedBox(),
                        PasswordForm(
                          start: _repassword_node,
                          title: "Re-enter Password",
                          controller: _repassowrd_controller,
                          validator: (value) {},
                          number: 0,
                        ),
                        OurSizedBox(),
                        OurSizedBox(),
                        Container(
                          height: ScreenUtil().setSp(40),
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setSp(22.5),
                          ),
                          width: double.infinity,
                          child: OurElevatedButton(
                            title: "Sign Up",
                            function: () async {
                              if (_user_controller.text.trim().isEmpty ||
                                  _repassowrd_controller.text.trim().isEmpty ||
                                  _password_controller.text.trim().isEmpty ||
                                  _email_controller.text.trim().isEmpty) {
                                OurToast()
                                    .showErrorToast("Field can't be empty");
                              }
                              if (_repassowrd_controller.text.trim() !=
                                  _password_controller.text.trim()) {
                                OurToast()
                                    .showErrorToast("Password doesn't match");
                              } else {
                                // var appSignatureID =
                                //     await SmsAutoFill().getAppSignature;
                                // print("==========");
                                // print("==========");
                                // print("==========");
                                // print("==========");
                                // print(appSignatureID);
                                // print("==========");
                                // print("==========");
                                // print("==========");
                                // print("==========");
                                // await PhoneAuth().sendLoginOTP(
                                //   _phone_number_controller.text.trim(),
                                //   context,
                                // );
                              }
                            },
                          ),
                        ),
                        OurSizedBox(),
                        Center(
                          child: FxButton.text(
                            onPressed: () async {
                              Navigator.pop(context);
                              // Navigator.push(
                              //   context,
                              //   PageTransition(
                              //     type: PageTransitionType.leftToRight,
                              //     child: ShoppingRegisterScreen(),
                              //   ),
                              // );
                              // MaterialPageRoute(
                              // builder: (context) => ShoppingRegisterScreen()));
                            },
                            child: FxText.b2(
                              "Already have an account? Sign In",
                              decoration: TextDecoration.underline,
                              fontSize: ScreenUtil().setSp(15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
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
}
