import 'package:dispatch/view/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:random_avatar/random_avatar.dart';

class RecruitPage extends StatefulWidget {
  const RecruitPage({super.key});

  @override
  _RecruitPageState createState() => _RecruitPageState();
}

class _RecruitPageState extends State<RecruitPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _obscurePassword = true;
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final passwordConfirmCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  String svgCode = "";

  @override
  void initState() {
    super.initState();
    generateAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          context.emptySizedHeightBoxLow3x,
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: GestureDetector(
              onTap: () {
                generateAvatar();
                setState(() {});
              },
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.asset("assets/images/male.png"),
              ),
            ),
          ),
          context.emptySizedHeightBoxLow3x,
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: CustomTextField(
              labelText: "需求日期",
            ),
          ),
          context.emptySizedHeightBoxLow,
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: CustomTextField(
              labelText: "派工地點",
            ),
          ),
          context.emptySizedHeightBoxLow,
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: CustomTextField(
              labelText: "案場照片",
            ),
          ),
          context.emptySizedHeightBoxLow,
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: CustomTextField(
              labelText: "再次確認密碼",
            ),
          ),
          Expanded(
            child: Container(),
          ),
          SizedBox(
            width: 180,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                /*Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );*/
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('註冊'),
            ),
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }

  void generateAvatar() {
    svgCode = RandomAvatarString(
        DateTime.now().millisecondsSinceEpoch.toRadixString(16));
  }
}
