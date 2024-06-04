import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/personal/worker/invoice/worker_invoice_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<OEMModel> invoice_list = [];
  int currentTab = 0;

  Future<void> retrieveinvoiceList() async {
    invoice_list = await WebAPI().getOEMLists(context, 1);
    for (var invoice in invoice_list) {
      print("invoiceID:${invoice.oem_id} \n");
      print("invoicePDF:${invoice.pdf}");
      print("invoiceArea: ${invoice.area}");
      print("invoiceAddress:${invoice.address}");
      print("invoiceWorker:${invoice.worker}");
      print("invoiceWorker:${invoice.worker_id}");
      print("-------------------");
    }
    print(invoice_list.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    retrieveinvoiceList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                context.emptySizedHeightBoxLow,
                Container(
                  height: 35,

                  // width: MediaQuery.of(context).size.width - 60.w,
                  decoration: BoxDecoration(
                      color: Color(0xffE5E4E4),
                      borderRadius: BorderRadius.circular(8)),
                  child: TabBar(
                    isScrollable: true,
                    labelStyle: TextStyle(
                        letterSpacing: 5.w,
                        color: Colors.black,
                        fontFamily: 'MicrosoftYaHei'),
                    indicator: BoxDecoration(
                      color: Color(0xffa7b6cc),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            '未上傳',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            '已上傳',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            '已完成',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                    onTap: (value) {
                      setState(() {
                        currentTab = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [buildList(), Container(), Container()],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildList() {
    List<OEMModel> completed_list = invoice_list
        .where((element) =>
            element.worker == getCurrentUser(context).user_id &&
            element.status == COMPLETED)
        .toList();
    print(completed_list.length);
    return ListView.builder(
      itemBuilder: ((context, index) {
        OEMModel model = completed_list[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 0,
                  blurRadius: 3,
                  //offset: Offset(3, 5),
                )
              ]),
          child: ExpansionTile(
            // shape: Border.all(color: Colors.black,strokeAlign: 2),
            title: Text('${model.oem_id}'),
            subtitle: Text('派工日期: ${getDateStringFromDB(model.date)}'),
            children: [
              Divider(
                height: 15.h,
                indent: 15.w,
                endIndent: 15.w,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '     客戶編號',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('${model.user_id}     ',
                      style: TextStyle(color: Colors.grey))
                ],
              ),
              Divider(
                height: 15.h,
                indent: 15.w,
                endIndent: 15.w,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('     地址', style: TextStyle(color: Colors.grey)),
                  Text('"${model.city}${model.area}${model.address}"    ',
                      style: TextStyle(color: Colors.grey))
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    '上傳請款單 >  ',
                    style: TextStyle(color: Color(0xff0069ab)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => InvoiceRequestPage(
                                  model: model,
                                ))));
                  },
                ),
              )
            ],
          ),
        );
      }),
      itemCount: completed_list.length,
    );
  }
}
