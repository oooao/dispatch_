import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/util/image_helper.dart';
import 'package:dispatch/view/oem/request_waiting_page.dart';
import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter/services.dart';

class UploadPhotoPage extends StatefulWidget {
  final OEMModel oemModel;
  const UploadPhotoPage({super.key, required this.oemModel});

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  final TextEditingController _textFieldController = TextEditingController();
  late OEMModel oemModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> photoList = [];
  fp.FilePickerResult? result;

  String? _fileName;
  bool _isLoading = false;
  bool _userAborted = false;
  @override
  void initState() {
    oemModel = widget.oemModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: buildForm(),
      ),
    );
  }

  Widget buildForm() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              context.emptySizedHeightBoxLow3x,
              Text(
                "請上傳施工區域及\n其他相關圖片",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              context.sized.emptySizedHeightBoxLow3x,
              SingleChildScrollView(
                child: buildPhotoList(),
              ),
              context.sized.emptySizedHeightBoxLow3x,
              //10/2號新增上傳PDF
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Text('上傳PDF',
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
              ),
              Container(
                width: 256.w,
                height: 144.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                  ),
                ),
                child: TextButton(
                  onPressed: () => _pickFiles(),
                  child: Text("Click to upload"),
                ),
              ),
              context.emptySizedHeightBoxLow3x,
              Builder(
                builder: (BuildContext context) => _isLoading
                    ? Center(
                        child: const CircularProgressIndicator(),
                      )
                    : _userAborted
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 8.h),
                                child: Text(
                                  'PDF讀取失敗',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                            ],
                          )
                        : result != null
                            ? Text(
                                _fileName!,
                                style: TextStyle(fontSize: 16.sp),
                              )
                            : const SizedBox(),
              ),
              SizedBox(
                height: 40.0.h,
              ),
              SizedBox(
                width: 180.w,
                height: 50.h,
                child: ElevatedButton(
                    onPressed: () async {
                      oemModel.photos = photoList;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return confrimDialog();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('下一步', style: TextStyle(fontSize: 20.sp))),
              ),
              context.emptySizedHeightBoxLow3x,
            ],
          ),
        ));
  }

  Column buildPhotoList() {
    List<Widget> lists = [];
    for (int i = 0; i < photoList.length; i++) {
      lists.add(buildPhotoGrid(i));
      lists.add(SizedBox(height: 10.h));
    }

    lists.add(buildEmptyPhoto());
    return Column(
      children: lists,
    );
  }

  Widget buildPhotoGrid(int index) {
    Widget photo = ImageHelper.imageFromBase64String(photoList[index]);
    return Container(
      width: 256.w,
      height: 144.h,
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

  Widget buildEmptyPhoto() {
    Widget photo = Image.asset("assets/images/iconAdd.png");
    return Container(
      width: 256.w,
      height: 144.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54,
        ),
      ),
      child: TextButton(
        onPressed: () async {
          List<String> photos = await ImageHelper.pickPhotos();
          setState(() {
            photoList.addAll(photos);
          });
        },
        child: photo,
      ),
    );
  }

  Widget confrimDialog() {
    return AlertDialog(
        title: Text('若有指定師傅，請在下方輸入框輸入師傅會員編號！否則由系統進行媒合！',
            style: TextStyle(fontSize: 20.sp)),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(
            hintText: "師傅會員編號",
            border: OutlineInputBorder(),
          ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                sendOem(true);
              },
              child: const Text('否')),
          TextButton(
              onPressed: () {
                if (_textFieldController.text.isEmpty) {
                  EasyLoading.showError('請輸入師傅編號');
                } else {
                  oemModel.worker_id = _textFieldController.text;
                  sendOem(false);
                }
              },
              child: const Text('是')),
        ]);
  }

  Future<void> sendOem(bool isWorkerNoEmpty) async {
    OEMModel result = await WebAPI().sendOEMRequest(context, oemModel);
    print(oemModel.worker_id);
    print(oemModel.pdf);
    print("[DEBUG] result: ${result.toJson()}");
    if (result.oem_id.isNotEmpty) {
      oemModel.oem_id = result.oem_id;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RequestWaitingPage(
                  isWorkerNoEmpty: isWorkerNoEmpty,
                  oemModel: oemModel,
                )),
      );
    } else {
      EasyLoading.showError("訂單發生錯誤！請洽詢客服！");
    }
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _fileName = null;
      result = null;
      _userAborted = false;
    });
  }

  void _pickFiles() async {
    _resetState();
    try {
      result = await fp.FilePicker.platform.pickFiles();
      print(result);
      if (result != null) {
        oemModel.pdf = result!.files.single.path!;
      }
    } catch (e) {
      //_logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = result != null ? result!.files.single.name : "...";
      _userAborted = result == null;
    });
  }
}
