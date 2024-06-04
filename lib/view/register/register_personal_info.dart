// import 'package:dispatch/view/login_page.dart';
// import 'package:dispatch/view/widgets/custom_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:kartal/kartal.dart';

// class RegisterPersonalInfoPage extends StatefulWidget {
//   const RegisterPersonalInfoPage({super.key});

//   @override
//   _RegisterPersonalInfoPageState createState() =>
//       _RegisterPersonalInfoPageState();
// }

// class _RegisterPersonalInfoPageState extends State<RegisterPersonalInfoPage> {
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
//         child: _Form(),
//       ),
//     );
//   }
// }

// class _Form extends StatefulWidget {
//   @override
//   __FormState createState() => __FormState();
// }

// class __FormState extends State<_Form> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late List<TextStyle?> otpTextStyles;
//   late List<TextEditingController?> controls;
//   int numberOfFields = 5;
//   bool clearText = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             context.emptySizedHeightBoxLow3x,
//             const Text(
//               "個人資料",
//               style: TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "電話驗證已通過！\n請在下方繼續輸入您的個人資料！",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 30),
//             const Padding(
//               padding: EdgeInsets.only(left: 40, right: 40),
//               child: CustomTextField(
//                 labelText: "用戶名稱",
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 40, right: 40),
//               child: CustomTextField(
//                 labelText: "聯絡地址",
//               ),
//             ),
//             const Spacer(),
//             SizedBox(
//               width: 180,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (context) {
//                       return AlertDialog(
//                         content: const Text(
//                           '您已完成註冊流程，\n按OK後返回登入頁面進行登入！',
//                           textAlign: TextAlign.center,
//                         ),
//                         actions: [
//                           TextButton(
//                             child: const Text("OK"),
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const LoginPage()),
//                               );
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//                 child: const Text('完成註冊'),
//               ),
//             ),
//             context.emptySizedHeightBoxLow3x,
//           ],
//         ),
//       ),
//     );
//   }
// }
