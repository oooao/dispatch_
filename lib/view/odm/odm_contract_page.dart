// import 'package:dispatch/util/common.dart';
// import 'package:dispatch/model/odm_model.dart';
// import 'package:dispatch/view/home_page.dart';
// import 'package:dispatch/view/navigationBar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:kartal/kartal.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class ODMContractPage extends StatefulWidget {
//   final ODMModel model;
//   final Uint8List signature;

//   const ODMContractPage(
//       {super.key, required this.signature, required this.model});

//   @override
//   _ODMContractPageState createState() => _ODMContractPageState();
// }

// class _ODMContractPageState extends State<ODMContractPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool confirm = false;
//   DateTime signDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset('assets/images/TextLogo.png'),
//         centerTitle: true,
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         child: Form(
//           key: _formKey,
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 context.emptySizedHeightBoxLow3x,
//                 Expanded(
//                   child: PdfPreview(
//                     initialPageFormat: PdfPageFormat.a4,
//                     canChangeOrientation: true,
//                     build: (format) => generateDocument(format),
//                     canDebug: false,
//                     canChangePageFormat: true,
//                   ),
//                 ),
//                 context.emptySizedHeightBoxLow3x,
//                 Container(
//                   child: CheckboxListTile(
//                     value: confirm,
//                     controlAffinity: ListTileControlAffinity.leading,
//                     onChanged: (value) {
//                       setState(() {
//                         confirm = value!;
//                       });
//                     },
//                     title: const Text(
//                       "我已確認以上需求無誤並同意送出申請！",
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),
//                 context.emptySizedHeightBoxLow,
//                 SizedBox(
//                   width: 180,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       showDialog(
//                         context: context,
//                         barrierDismissible: false,
//                         builder: (context) {
//                           return AlertDialog(
//                             content: const Text(
//                               '需求已送出！將會有專人與您聯繫！;',
//                               textAlign: TextAlign.center,
//                             ),
//                             actions: [
//                               TextButton(
//                                 child: const Text("OK"),
//                                 onPressed: () {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const BottomBarPage()),
//                                   );
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                     ),
//                     child: const Text('確認'),
//                   ),
//                 ),
//                 context.emptySizedHeightBoxLow3x,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<Uint8List> generateDocument(PdfPageFormat format) async {
//     final doc = pw.Document(pageMode: PdfPageMode.outlines);

//     var fd = await rootBundle.load('assets/fonts/GenYoMinTW-Regular.ttf');
//     var font1 = pw.Font.ttf(fd);

//     doc.addPage(
//       pw.Page(
//         pageTheme: pw.PageTheme(
//           pageFormat: format.copyWith(
//             marginBottom: 0,
//             marginLeft: 0,
//             marginRight: 0,
//             marginTop: 0,
//           ),
//           orientation: pw.PageOrientation.portrait,
//           theme: pw.ThemeData.withFont(
//             base: font1,
//           ),
//         ),
//         build: (context) {
//           return pw.Padding(
//             padding: const pw.EdgeInsets.only(
//               top: 10,
//               left: 10,
//               right: 10,
//               bottom: 10,
//             ),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.SizedBox(height: 20),
//                 pw.Text(legal, style: const pw.TextStyle(fontSize: 14)),
//                 pw.SizedBox(height: 20),
//                 pw.Text("公司簽名：",
//                     style: const pw.TextStyle(
//                         fontSize: 14, color: PdfColors.black)),
//                 pw.SizedBox(height: 20),
//                 pw.Row(children: [
//                   pw.Text("客戶簽名：", style: const pw.TextStyle(fontSize: 14)),
//                   pw.SizedBox(
//                     height: 40,
//                     child: pw.Image(pw.MemoryImage(widget.signature)),
//                   ),
//                 ]),
//                 pw.SizedBox(height: 20),
//                 pw.Text("合約日期：${DateTime.now().toString().split(" ").first}",
//                     style: const pw.TextStyle(fontSize: 14)),
//               ],
//             ),
//           );
//         },
//       ),
//     );

//     return await doc.save();
//   }
// }
