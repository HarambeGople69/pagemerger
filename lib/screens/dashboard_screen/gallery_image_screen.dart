import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:myapp/controller/image_urls_controller.dart';
import 'package:myapp/screens/dashboard_screen/pdf_viewer.dart';
import 'package:myapp/services/compress%20image/compress_image.dart';
import 'package:myapp/utils/color.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:myapp/widgets/our_spinner.dart';
import '../../controller/login_controller.dart';

class GalleryImageOpener extends StatefulWidget {
  const GalleryImageOpener({super.key});

  @override
  State<GalleryImageOpener> createState() => _GalleryImageOpenerState();
}

class _GalleryImageOpenerState extends State<GalleryImageOpener> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<ImageUrlController>().initialize();
  }

  final pdf = pw.Document();
  List<File> _imagePick = [];
  List<Asset> _images = <Asset>[];
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: false,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          statusBarColor: "#d65338",
          actionBarColor: "#d65338",
          actionBarTitle: "Pick images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#d65338",
          startInAllView: true,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _images = resultList;
      // AssetToImage();
    });
  }

  // AssetToImage() async {
  //   for (var item in _images) {
  //     String pathss =
  //         await FlutterAbsolutePath.getAbsolutePath(item.identifier);
  //     if (pathss != null) {
  //       var a = await compressFile(File(item));

  //       _imagePick.add(a);
  //     }
  //     print("0000000000000===>>>$pathss");
  //     // _imagePick.add(File(pathss));
  //     setState(() {});
  //   }
  // }

  // getCroppedImaged(index) async {
  //   String pathss =
  //       await FlutterAbsolutePath.getAbsolutePath(_images[index].identifier);
  //   CroppedFile? croppedFile = await ImageCropper().cropImage(
  //       sourcePath: pathss,
  //       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  //       maxWidth: 700,
  //       maxHeight: 700,
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.square,
  //         CropAspectRatioPreset.ratio3x2,
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.ratio4x3,
  //         CropAspectRatioPreset.ratio16x9
  //       ],
  //       uiSettings: [
  //         AndroidUiSettings(
  //             toolbarColor: Color(0xffd65338),
  //             toolbarTitle: "Edit Image",
  //             showCropGrid: false,
  //             backgroundColor: Colors.white,
  //             statusBarColor: Color(0xffd65338),
  //             lockAspectRatio: false)
  //       ]);
  //   if (croppedFile != null) {
  //     setState(() {
  //       _imagePick[index] = croppedFile as File;
  //     });
  //   }
  // }

  List<String> imagefiles = [];

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 2.0,
      mainAxisSpacing: 2.0,
      children: List.generate(_imagePick.length, (index) {
        return GestureDetector(
            onTap: () {
              // getCroppedImaged(index);
            },
            child: Image.file(
              _imagePick[index],
              fit: BoxFit.cover,
            ));
      }),
    );
  }

  final controller = MultiImagePickerController(
      maxImages: 200,
      allowedImageTypes: ['png', 'jpg', 'jpeg'],
      withData: true,
      withReadStream: true,
      images: <ImageFile>[] // array of pre/default selected images
      );
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: Get.find<LoginController>().processing.value,
        progressIndicator: OurSpinner(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Gallery",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(25),
              ),
            ),
            backgroundColor: logoColor,
            centerTitle: true,
            elevation: 0,
          ),
          body: SafeArea(
              child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(10),
              vertical: ScreenUtil().setSp(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OurSizedBox(),
                  MultiImagePickerView(
                    controller: controller,
                    draggable: true,
                    showAddMoreButton: true,
                    showInitialContainer: true,
                    onChange: (images) {
                      // print(images);

                      imagefiles.clear();
                      images.forEach((element) {
                        imagefiles.add(element.path!);
                        // print(element.path);
                      });
                      setState(() {});
                      // List<String> data = [];
                      // images.forEach((element) {
                      //   print(element.path);
                      //   data.add(element.path!);
                      // });
                      // Get.find<ImageUrlController>().addData(data);
                      // callback to update images
                    },
                  ),
                  OurSizedBox(),
                  OurSizedBox(),
                  imagefiles.isNotEmpty
                      ? OurElevatedButton(
                          title: "Convert into PDF",
                          function: () {
                            createPDF();
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  createPDF() async {
    print("Inside create PDF");
    for (var img in imagefiles) {
      File compressedImage = await compressImage(File(img));
      final image = pw.MemoryImage(compressedImage.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a3,
          build: (pw.Context context) {
            return pw.Center(child: pw.Image(image));
          }));
      final file = File("${DateTime.now()}.pdf");
      await file.writeAsBytes(await pdf.save());
      print(file);
      // Navigator.push(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.leftToRight,
      //     child: OurPdfViewer(
      //       pdfFile: file,
      //     ),
      //   ),
      // );
    }
  }
}
