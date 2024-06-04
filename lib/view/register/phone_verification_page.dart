// import 'package:dispatch/view/login_page.dart';
// import 'package:dispatch/view/register/register_personal_info.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:kartal/kartal.dart';

// class PhoneVerificationPage extends StatefulWidget {
//   final String verificationId;
//   const PhoneVerificationPage({super.key, required this.verificationId});

//   @override
//   _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
// }

// class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late List<TextStyle?> otpTextStyles;
//   late List<TextEditingController?> controls;
//   int numberOfFields = 6;
//   bool clearText = false;
//   String smsOTP = "";

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
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         child: buildForm(),
//       ),
//     );
//   }

//   Widget buildForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           context.emptySizedHeightBoxLow3x,
//           const Text(
//             "電話驗證",
//             style: TextStyle(fontSize: 24),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             "您好，驗證碼已送至您的手機！\n請在下方輸入您收到的驗證碼！",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 30),
//           OtpTextField(
//             numberOfFields: numberOfFields,
//             clearText: clearText,
//             showFieldAsBox: true,
//             onCodeChanged: (String value) {
//               //Handle each value
//               smsOTP = value;
//             },
//             handleControllers: (controllers) {
//               //get all textFields controller, if needed
//               controls = controllers;
//             },
//             onSubmit: (String verificationCode) {
//               //set clear text to clear text from all fields
//               print(verificationCode);
//               smsOTP = verificationCode;
//             }, // end onSubmit
//           ),
//           const Spacer(),
//           SizedBox(
//             width: 180,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: () async {
//                 final AuthCredential credential = PhoneAuthProvider.credential(
//                   verificationId: widget.verificationId,
//                   smsCode: smsOTP,
//                 );
//                 try {
//                   await FirebaseAuth.instance.signInWithCredential(credential);
//                   EasyLoading.showToast("行動電話號已驗證成功！");
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => const RegisterPersonalInfoPage()),
//                   );
//                 } catch (e) {
//                   EasyLoading.showToast("驗證碼錯誤，請重新輸入！");
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//               ),
//               child: const Text('驗證'),
//             ),
//           ),
//           context.emptySizedHeightBoxLow3x,
//         ],
//       ),
//     );
//   }
// }
