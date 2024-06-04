// import 'package:dispatch/view/register/phone_verification_page.dart';
// import 'package:dispatch/view/widgets/custom_widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kartal/kartal.dart';
// import 'package:random_avatar/random_avatar.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
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
//   final bool _obscurePassword = true;
//   final phoneController = TextEditingController();
//   final passwordCtrl = TextEditingController();
//   final passwordConfirmCtrl = TextEditingController();
//   final userNameCtrl = TextEditingController();
//   String svgCode = "";
//   String smsOTP = "";
//   String verificationId = "";
//   String errorMessage = "";
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();
//     generateAvatar();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             context.emptySizedHeightBoxLow3x,
//             Container(
//               padding: const EdgeInsets.only(top: 20, bottom: 5),
//               child: GestureDetector(
//                 onTap: () {
//                   generateAvatar();
//                   setState(() {});
//                 },
//                 child: SizedBox(
//                   width: 120,
//                   height: 120,
//                   child: Image.asset("assets/images/male.png"),
//                 ),
//               ),
//             ),
//             context.emptySizedHeightBoxLow3x,
//             Padding(
//               padding: EdgeInsets.only(left: 10, right: 10),
//               child: CustomTextField(
//                 controller: phoneController,
//                 labelText: "帳號（請輸入手機號碼)",
//               ),
//             ),
//             context.emptySizedHeightBoxLow3x,
//             Padding(
//               padding: EdgeInsets.only(left: 10, right: 10),
//               child: CustomTextField(
//                 controller: passwordCtrl,
//                 labelText: "密碼",
//               ),
//             ),
//             context.emptySizedHeightBoxLow3x,
//             const Padding(
//               padding: EdgeInsets.only(left: 10, right: 10),
//               child: CustomTextField(
//                 labelText: "再次確認密碼",
//               ),
//             ),
//             context.emptySizedHeightBoxLow3x,
//             context.emptySizedHeightBoxLow3x,
//             SizedBox(
//               width: 180,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   verifyPhone();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => PhoneVerificationPage(
//                             verificationId: verificationId)),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//                 child: const Text('發送驗證碼'),
//               ),
//             ),
//             context.emptySizedHeightBoxLow3x,
//           ],
//         ),
//       ),
//     );
//   }

//   void generateAvatar() {
//     svgCode = RandomAvatarString(
//         DateTime.now().millisecondsSinceEpoch.toRadixString(16));
//   }

//   Future<void> verifyPhone() async {
//     String phone = phoneController.text;
//     smsOTPSent(String verId, int? forceCodeResend) {
//       verificationId = verId;
//       print("[DEBUG] smsOTPSent, verificationId = $verificationId");
//       EasyLoading.dismiss();
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 PhoneVerificationPage(verificationId: verificationId)),
//       );
//     }

//     try {
//       if (!phone.startsWith("+") &&
//           (phone.length != 10 || !phone.startsWith("0"))) {
//         EasyLoading.showError("請輸入10碼行動電話號碼");
//         return;
//       }
//       if (phone.startsWith("0")) {
//         phone = phone.replaceFirst("0", "+886");
//       }
//       EasyLoading.show();

//       print("[DEBUG] verifyPhoneNumber: $phone");
//       await _auth.verifyPhoneNumber(
//           phoneNumber: phone, // PHONE NUMBER TO SEND OTP
//           codeAutoRetrievalTimeout: (String verId) {
//             //Starts the phone number verification process for the given phone number.
//             //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
//             verificationId = verId;
//             print("[DEBUG] verificationId = $verificationId");
//           },
//           codeSent:
//               smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
//           timeout: const Duration(seconds: 20),
//           verificationCompleted: (AuthCredential phoneAuthCredential) {
//             print("[DEBUG] phoneAuthCredential = $phoneAuthCredential");
//             EasyLoading.dismiss();
//           },
//           verificationFailed: (exceptio) {
//             print('${exceptio.message}');
//             print("[DEBUG] exceptio: ${exceptio.message}");
//             EasyLoading.dismiss();
//           });
//     } catch (e) {
//       print(e);
//     }
//   }
// }
