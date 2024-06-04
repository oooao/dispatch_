import 'package:dispatch/view/odm/odm_verify_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<bool> Authentication(String verId, String smsOTP) async {
  final AuthCredential credential = PhoneAuthProvider.credential(
    verificationId: verId,
    smsCode: smsOTP,
  );
  try {
    EasyLoading.show();
    await FirebaseAuth.instance.signInWithCredential(credential);
    EasyLoading.dismiss();
    EasyLoading.showToast("行動電話號已驗證成功！");
    return true;
  } catch (e) {
    EasyLoading.showToast("驗證碼錯誤，請重新輸入！");
    return false;
  }
}

Future<String> verifyPhone(String phoneNumber, BuildContext context,
    String? nextPage, dynamic model) async {
  String verificationId = "";
  String phone = phoneNumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  smsOTPSent(String verId, int? forceCodeResend) {
    print("[DEBUG] smsOTPSent, verificationId = $verId");

    EasyLoading.dismiss();
    if (nextPage!.isNotEmpty) {
      switch (nextPage) {
        case "ODMVerifyPage":
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ODMVerifyPage(model: model, verId: verId)),
          );
      }
    }
    return verId;
  }

  try {
    if (!phone.startsWith("+") &&
        (phone.length != 10 || !phone.startsWith("0"))) {
      EasyLoading.showError("請輸入10碼行動電話號碼");
      return verificationId;
    }
    if (phone.startsWith("0")) {
      phone = phone.replaceFirst("0", "+886");
    }
    EasyLoading.show();
    print("[DEBUG] verifyPhoneNumber: $phone");
    await _auth.verifyPhoneNumber(
        phoneNumber: phone, // PHONE NUMBER TO SEND OTP
        codeAutoRetrievalTimeout: (String verId) {
          //Starts the phone number verification process for the given phone number.
          //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
          verificationId = verId;
          print("[DEBUG] verificationId = $verificationId");
        },
        codeSent:
            smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
        timeout: const Duration(seconds: 20),
        verificationCompleted: (AuthCredential phoneAuthCredential) {
          print("[DEBUG] phoneAuthCredential = $phoneAuthCredential");
          EasyLoading.showToast('您好，驗證碼已送至您的手機！\n請在下方輸入您收到的驗證碼！');
        },
        verificationFailed: (exceptio) {
          print('${exceptio.message}');
          print("[DEBUG] exceptio: ${exceptio.message}");
          EasyLoading.dismiss();
          EasyLoading.showError('處理錯誤，請稍後再試');
        });
    return verificationId;
  } catch (e) {
    print(e);
    return verificationId;
  }
}
