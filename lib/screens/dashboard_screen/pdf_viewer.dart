// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class OurPdfViewer extends StatefulWidget {
//   final File pdfFile;
//   const OurPdfViewer({
//     Key? key,
//     required this.pdfFile,
//   }) : super(key: key);

//   @override
//   State<OurPdfViewer> createState() => _OurPdfViewerState();
// }

// class _OurPdfViewerState extends State<OurPdfViewer> {
//   PdfViewerController _pdfViewerController = PdfViewerController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Syncfusion Flutter PdfViewer'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.zoom_in,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               _pdfViewerController.zoomLevel = 2;
//             },
//           ),
//         ],
//       ),
//       body: SfPdfViewer.file(
//         widget.pdfFile,
//         controller: _pdfViewerController,
//       ),
//     );
//   }
// }
