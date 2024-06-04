// import 'package:dispatch/util/common.dart';
// import 'package:flutter/material.dart';
// import 'package:kartal/kartal.dart';

// class ODMContactPage extends StatefulWidget {
//   const ODMContactPage({super.key});

//   @override
//   _ODMContactPageState createState() => _ODMContactPageState();
// }
// // 2023/10 無用
// class _ODMContactPageState extends State<ODMContactPage> {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset('assets/images/TextLogo.png'),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         child: Form(
//           child: SingleChildScrollView(
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   context.emptySizedHeightBoxHigh,
//                   Padding(
//                     padding: const EdgeInsets.only(left: 40, right: 40),
//                     child: Image.asset("assets/images/line.png", width: 200),
//                   ),
//                   context.emptySizedHeightBoxLow3x,
//                   Container(
//                     child: Text("您的需求已送出\n我們將派專員聯繫您",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: primaryTextColor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                   context.emptySizedHeightBoxLow3x,
//                   SizedBox(
//                     width: 180,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         Navigator.of(context).pop();
//                         Navigator.of(context).pop();
//                         Navigator.of(context).pop();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                       ),
//                       child: const Text('關閉'),
//                     ),
//                   ),
//                   context.emptySizedHeightBoxLow3x,
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
