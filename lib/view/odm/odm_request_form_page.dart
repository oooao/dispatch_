import 'package:dispatch/model/odm_model.dart';
import 'package:dispatch/util/open_api.dart';
import 'package:dispatch/view/odm/odm_selection_page.dart';
import 'package:dispatch/view/widgets/custom_widgets.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';


// 2023/10 重製畫面
class ODMRequestFormPage extends StatefulWidget {
  const ODMRequestFormPage({super.key});

  @override
  _ODMRequestFormPageState createState() => _ODMRequestFormPageState();
}

class _ODMRequestFormPageState extends State<ODMRequestFormPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: _Form(),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Map<String, dynamic> _city_list = {};
  String _selectedCity = "";
  Map<String, dynamic> _area_list = {};
  String _selectedArea = "";

  @override
  void initState() {
    super.initState();
    loadCountryList();
  }

  Future<void> loadCountryList() async {
    _city_list = await OpenApi.getCountryList();
    if (_city_list.isNotEmpty) {
      _selectedCity = _city_list.keys.first;
    }
    await loadAreaList();
    setState(() {});
  }

  Future<void> loadAreaList() async {
    print("loadAreaList: _selectedCity = $_selectedCity");
    _area_list = await OpenApi.getAreaList(_selectedCity);
    if (_area_list.isNotEmpty) {
      _selectedArea = _area_list.keys.first;
    }
    print("======== loadAreaList ======");
    print("_area_list: $_area_list");
    print("_selectedArea: $_selectedArea");
    print("===========================");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                '吉時ODM',
                style: TextStyle(fontSize: 16, letterSpacing: 5),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            FormBackground(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  children: [
                    context.emptySizedHeightBoxNormal,
                    context.emptySizedHeightBoxLow,
                    CustomTextField(
                      controller: nameController,
                      labelText: "業主名稱",
                      hinttext: "請輸入業主名稱",
                    ),
                    context.emptySizedHeightBoxNormal,
                    context.emptySizedHeightBoxLow3x,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton2(
                          iconStyleData: IconStyleData(icon: Container()),
                          underline: Container(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontFamily: 'MicrosoftYaHei',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.center,
                          buttonStyleData: ButtonStyleData(
                              width: 110.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1),
                                  borderRadius: BorderRadius.circular(30))),
                          value: _selectedCity,
                          onChanged: (value) => {
                            setState((() {
                              _selectedCity = value!;
                              loadAreaList();
                            }))
                          },
                          items: _city_list.keys.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                _city_list[item],
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          hint: Text('聯絡地址(縣市)'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        DropdownButton2(
                          iconStyleData: IconStyleData(icon: Container()),
                          underline: Container(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontFamily: 'MicrosoftYaHei',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.center,
                          buttonStyleData: ButtonStyleData(
                              height: 35.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1),
                                  borderRadius: BorderRadius.circular(30))),
                          value: _selectedArea,
                          onChanged: (value) => {
                            setState((() {
                              _selectedArea = value!;
                            }))
                          },
                          items: _area_list.keys.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                _area_list[item],
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          hint: const Text('請選擇地區'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      hinttext: '請輸入詳細地點',
                      labelText: '施工地點',
                      controller: addressController,
                    ),
                    context.emptySizedHeightBoxNormal,
                    context.emptySizedHeightBoxLow,
                    CustomTextField(
                      labelText: "聯絡時間",
                      hinttext: "請選擇聯絡時間",
                      controller: dateController,
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2023, 01),
                                lastDate: DateTime(2100, 12))
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              dateController.text =
                                  value.toString().split(" ").first;
                            });
                          } else {
                            setState(() {
                              dateController.text = "";
                            });
                          }
                        });
                      },
                    ),
                    context.emptySizedHeightBoxHigh,
                    CustomTextField(
                      controller: phoneController,
                      labelText: "聯絡電話",
                      hinttext: "請輸入聯絡電話",
                    ),
                    context.emptySizedHeightBoxLow3x,
                  ],
                ),
              ),
            ),
            SizedBox(
              //width: 180,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () async {
                  ODMModel model = ODMModel(photos: []);
                  model.name = nameController.text;
                  model.address = _city_list[_selectedCity] +
                      _area_list[_selectedArea] +
                      addressController.text;

                  model.date = dateController.text != ""
                      ? (DateTime.parse(dateController.text)
                                  .millisecondsSinceEpoch /
                              1000)
                          .toStringAsFixed(0)
                      : "";
                  model.phone = phoneController.text;
                  if (model.name.isEmpty) {
                    EasyLoading.showError("請輪入業主名稱！");
                    return;
                  }
                  if (model.address.isEmpty) {
                    EasyLoading.showError("請輪入施工地點！");
                    return;
                  }
                  if (model.date.isEmpty) {
                    EasyLoading.showError("請輪入聯絡時間！");
                    return;
                  }
                  if (model.phone.isEmpty) {
                    EasyLoading.showError("請輪入聯絡電話！");
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ODMSelectionPage(model: model)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0.5,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Text('Next',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xff0069ab),
                        fontFamily: 'MicrosoftYaHei',
                        //letterSpacing: 8.w,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
