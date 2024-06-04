import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/invite/application_page.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:styled_text/styled_text.dart';

class AgreementPage extends StatefulWidget {
  const AgreementPage({super.key});

  @override
  _AgreementPageState createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
        //automaticallyImplyLeading: false,
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
  bool confirm = false;

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
        child: Column(
          children: [
            context.emptySizedHeightBoxLow3x,
            const Text(
              "請先詳閱以下招工協議書以繼續！",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: StyledText(
                      text: privacy,
                      tags: {
                        'bold': StyledTextTag(
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      },
                    )),
              ),
            ),
            Container(
              child: CheckboxListTile(
                value: confirm,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    confirm = value!;
                  });
                },
                title: const Text(
                  "本人已詳細閱讀並充分理解且同意遵守以上條款。",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 180,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (confirm == false) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text('請勾選同意條款後方可繼續！'),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ApplicationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('確認'),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
          ],
        ),
      ),
    );
  }
}
