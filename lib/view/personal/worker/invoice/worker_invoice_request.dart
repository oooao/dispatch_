import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/invoice_model.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class InvoiceRequestPage extends StatefulWidget {
  OEMModel model;
  InvoiceRequestPage({super.key, required this.model});

  @override
  State<InvoiceRequestPage> createState() => _InvoiceRequestPageState();
}

class _InvoiceRequestPageState extends State<InvoiceRequestPage> {
  final contentController = TextEditingController();
  final unitController = TextEditingController();
  final amountController = TextEditingController();
  final sizeController = TextEditingController();
  final unitPriceController = TextEditingController();
  final totalPriceController = TextEditingController();
  final noteController = TextEditingController();
  final totalSizeController = TextEditingController();
  late List<Map<String, dynamic>> items = [];
  late InvoiceModel model = InvoiceModel(item_and_description: []);

  @override
  void initState() {
    super.initState();
    model.oem_id = widget.model.oem_id;
    print("OEM_ID:${model.oem_id}");
  }

  @override
  void dispose() {
    contentController.dispose();
    unitController.dispose();
    amountController.dispose();
    sizeController.dispose();
    totalPriceController.dispose();
    totalSizeController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/TextLogo.png'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 3, spreadRadius: 0, color: Colors.grey)
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.model.oem_id}',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    Text('師傅編號\n${widget.model.worker}')
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child:
                      Text('派工日期: ${getDateStringFromDB(widget.model.date)}'),
                ),
                context.emptySizedHeightBoxLow3x,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '客戶編號',
                    ),
                    Text('${widget.model.user_id}')
                  ],
                ),
                context.emptySizedHeightBoxLow3x,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '地址',
                    ),
                    Text(
                        '${widget.model.address}${widget.model.city}${widget.model.area}')
                  ],
                ),
                context.emptySizedHeightBoxLow3x,
                CustomTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   
                  controller: contentController,
                  labelText: '組裝內容',
                ),
                context.emptySizedHeightBoxLow3x,
                CustomTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: unitController,
                  labelText: '單位',
                ),
                context.emptySizedHeightBoxLow3x,
                CustomTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: amountController,
                  labelText: '數量',
                ),
                context.emptySizedHeightBoxLow3x,
                CustomTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: sizeController,
                  labelText: '尺寸',
                ),
                context.emptySizedHeightBoxLow3x,
                CustomTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: totalSizeController,
                  labelText: '總尺寸',
                ),
                context.emptySizedHeightBoxLow3x,
                CustomTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: unitPriceController,
                  labelText: '單價',
                ),
                context.emptySizedHeightBoxLow3x,
                CustomTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: totalPriceController,
                  labelText: '金額',
                ),
                context.emptySizedHeightBoxLow3x,
                CustomTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: noteController,
                  labelText: '備註',
                ),
                context.emptySizedHeightBoxLow3x,
                SizedBox(
                  width: 140.w,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> item = {};
                      item["contents"] = contentController.text;
                      item["unit"] = unitController.text;
                      item["list"] = [
                        {
                          'count': amountController.text,
                          "size": sizeController.text
                        },
                      ];
                      item["total_size"] = totalSizeController.text;
                      item["unit_price"] = unitPriceController.text;
                      item["total_price"] = totalPriceController.text;
                      item["note"] = noteController.text;
                      items.add(item);
                      model.item_and_description = items;
                      sendRequest();
                      items.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      '確認上傳',
                      style: TextStyle(
                          fontFamily: 'MicrosoftYaHei',
                          letterSpacing: 3.w,
                          fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> sendRequest() async {
    if (await WebAPI().uploadInvoice(context, model)) {
      EasyLoading.showSuccess("已上傳成功");
      Navigator.of(context).pop();
      return;
    } else {
      EasyLoading.showError("上傳發生錯誤！請洽詢客服！");
    }
  }
}
