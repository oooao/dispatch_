import 'dart:io';

import 'package:dispatch/util/image_helper.dart';
import 'package:dispatch/view/home_page.dart';
import 'package:dispatch/view/navigationBar.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
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
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> controls;
  int numberOfFields = 5;
  bool clearText = false;
  bool _personal = true;
  String _front = "";
  String _back = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              context.emptySizedHeightBoxLow3x,
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("申請身份", style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Checkbox(
                            value: _personal,
                            onChanged: ((value) {
                              setState(() {
                                _personal = true;
                              });
                            }),
                          ),
                          const Text("個人"),
                          const SizedBox(width: 10),
                          Checkbox(
                            value: !_personal,
                            onChanged: ((value) {
                              setState(() {
                                _personal = false;
                              });
                            }),
                          ),
                          const Text("團隊"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("名片上傳", style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 5),
                    const Text("名片正面"),
                    const SizedBox(height: 5),
                    _front.isEmpty
                        ? buildEmptyPhoto(true)
                        : buildPhotoGrid(true),
                    const SizedBox(height: 20),
                    const Text("名片背面"),
                    const SizedBox(height: 5),
                    _back.isEmpty
                        ? buildEmptyPhoto(false)
                        : buildPhotoGrid(false),
                  ],
                ),
              ),
              context.emptySizedHeightBoxLow3x,
              SizedBox(
                width: 180,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                            '已送出申請！請耐心等侯審核結果！;',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomBarPage()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('送出申請'),
                ),
              ),
              context.emptySizedHeightBoxLow3x,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPhotoGrid(bool isFront) {
    Widget photo = Image.file(File(isFront ? _front : _back));
    return Container(
      width: 256,
      height: 144,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
        ),
      ),
      child: TextButton(
        onPressed: () async {
          //
        },
        child: photo,
      ),
    );
  }

  Widget buildEmptyPhoto(bool isFront) {
    Widget photo = Icon(Icons.add);
    return Container(
      width: 256,
      height: 144,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black54,
        ),
      ),
      child: TextButton(
        onPressed: () async {
          List<String> photos = await ImageHelper.pickPhotos(count: 1);
          if (photos.length == 1) {
            setState(() {
              if (isFront) {
                _front = photos.first;
              } else {
                _back = photos.first;
              }
            });
          }
        },
        child: photo,
      ),
    );
  }
}
